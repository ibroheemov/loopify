import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/participant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ChallengeRemoteDatasource {
  Future<List<Challenge>> getChallenges();
  Future<void> joinChallenge(JoinChallengeParams params);
  Future<void> leaveChallenge(String challengeId);
  Future<bool> isUserInChallenge(String challengeId);
  Future<List<Participant>> getWeeklyLeaderboard(String challengeId);
}

class ChallengeRemoteDatasourceImpl extends ChallengeRemoteDatasource {
  final FirebaseFirestore firestore;

  ChallengeRemoteDatasourceImpl({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<bool> isUserInChallenge(String challengeId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not signed in");

    final participantRef = firestore
        .collection('challenges')
        .doc(challengeId)
        .collection('participants')
        .doc(user.uid);

    final docSnap = await participantRef.get();
    return docSnap.exists;
  }

  @override
  Future<List<Challenge>> getChallenges() async {
    try {
      final snapshot = await firestore.collection('challenges').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Challenge(
          id: doc.id,
          title: data['title'] as String,
          description: data['description'] as String,
          duration: data['duration'] as int,
          goal: Goal.fromJson(data['goal']),
          forMuslims: data['forMuslims'] as bool,
          color: data['color'] as String,
          hadith_ar: data['hadith_ar'] as String,
          hadith_en: data['hadith_en'] as String,
          participants: data['participants'] as int,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }

  Future<User?> signInAnonymously() async {
    try {
      // ✅ Step 1: Ensure user is logged in
      final auth = FirebaseAuth.instance;
      User? currentUser = auth.currentUser;

      if (currentUser == null) {
        // Sign in anonymously
        final cred = await auth.signInAnonymously();
        currentUser = cred.user;
      }
      return currentUser;
    } catch (e) {
      throw Exception('Failed to sign in user anonymously: $e');
    }
  }

  @override
  Future<void> joinChallenge(params) async {
    final user = await signInAnonymously();
    if (user == null) throw Exception("User not signed in");

    final challengeRef =
        firestore.collection('challenges').doc(params.challengeId);
    final participantRef =
        challengeRef.collection('participants').doc(user.uid);

    await firestore.runTransaction((transaction) async {
      final participantSnap = await transaction.get(participantRef);

      if (!participantSnap.exists) {
        // Add participant with initial progress
        transaction.set(participantRef, {
          // 'joinedAt': FieldValue.serverTimestamp(),
          'progress': 0,
          // 'streak': 0,
          'displayName': params.displayName,
          // 'lastUpdated': FieldValue.serverTimestamp(),
        });

        // Increment participant count
        transaction.update(challengeRef, {
          'participants': FieldValue.increment(1),
        });
      } else {
        // Already joined, optionally update name
        transaction.update(participantRef, {
          'displayName': params.displayName,
          'lastUpdated': FieldValue.serverTimestamp(),
        });
      }
    });
  }

  @override
  Future<void> leaveChallenge(String challengeId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not signed in");

    final challengeRef = firestore.collection('challenges').doc(challengeId);
    final participantRef =
        challengeRef.collection('participants').doc(user.uid);

    await firestore.runTransaction((transaction) async {
      final participantSnap = await transaction.get(participantRef);

      if (participantSnap.exists) {
        // Remove participant doc
        transaction.delete(participantRef);

        // Decrement participant count
        transaction.update(challengeRef, {
          'totalParticipants': FieldValue.increment(-1),
        });
      }
    });
  }

  @override
  Future<List<Participant>> getWeeklyLeaderboard(String challengeId) async {
    try {
      final participantsRef = FirebaseFirestore.instance
          .collection('challenges')
          .doc(challengeId)
          .collection('participants');

      // 1️⃣ Get top 3 participants
      final top3Snap = await participantsRef
          .orderBy('totalProgress', descending: true)
          .limit(3)
          .get();

      // No participants yet
      if (top3Snap.docs.isEmpty) {
        return [];
      }

      final top3Participants = top3Snap.docs.map((doc) {
        final data = doc.data();
        return Participant(
          id: doc.id,
          displayName: data['displayName'] as String,
          totalProgress: data['totalProgress'] as int,
        );
      }).toList();

      // 2️⃣ Get the last progress value in the top 3
      final lastProgressInTop3 = top3Participants.last.totalProgress;

      // 3️⃣ Get ALL participants tied with that last progress (if more than 3)
      final tiedSnap = await participantsRef
          .where('totalProgress', isEqualTo: lastProgressInTop3)
          .get();

      final topWithTies = {for (var p in top3Participants) p.id: p};

      for (var doc in tiedSnap.docs) {
        topWithTies.putIfAbsent(doc.id, () {
          final data = doc.data();
          return Participant(
            id: doc.id,
            displayName: data['displayName'] as String,
            totalProgress: data['totalProgress'] as int,
          );
        });
      }

      final finalTopList = topWithTies.values.toList();

      return finalTopList;
    } catch (e) {
      rethrow;
    }
  }
}
