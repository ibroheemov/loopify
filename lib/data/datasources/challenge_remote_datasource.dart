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
  Stream<List<RankGroup>> getWeeklyLeaderboardStream(String challengeId);
  Future<void> updateProgress(UpdateProgressParams params);
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
          hadithAr: data['hadith_ar'] as String,
          hadithEn: data['hadith_en'] as String,
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
          'totalProgress': 0,
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
          'participants': FieldValue.increment(-1),
        });
      }
    });
  }

  @override
  Stream<List<RankGroup>> getWeeklyLeaderboardStream(String challengeId) {
    final participantsRef = FirebaseFirestore.instance
        .collection('challenges')
        .doc(challengeId)
        .collection('participants');

    return participantsRef
        .orderBy('totalProgress', descending: true)
        .snapshots()
        .map((snapshot) {
      final List<RankGroup> ranks = [];
      int currentRank = 1;
      int? lastProgress;

      final docs = snapshot.docs;
      int index = 0;

      while (ranks.length < 3 && index < docs.length) {
        final progress = docs[index]['totalProgress'] as int;

        if (lastProgress == null || progress < lastProgress) {
          final tiedParticipants =
              docs.where((doc) => doc['totalProgress'] == progress).map((doc) {
            final data = doc.data();
            return Participant(
              id: doc.id,
              displayName: data['displayName'],
              totalProgress: data['totalProgress'],
            );
          }).toList();

          ranks.add(
              RankGroup(rank: currentRank, participants: tiedParticipants));
          currentRank++;
          lastProgress = progress;
        }

        index++;
      }

      return ranks;
    });
  }

  Future<List<RankGroup>> getWeeklyLeaderboard(String challengeId) async {
    try {
      final participantsRef = FirebaseFirestore.instance
          .collection('challenges')
          .doc(challengeId)
          .collection('participants');

      final List<RankGroup> ranks = [];
      int currentRank = 1;
      int? lastProgress;

      while (ranks.length < 3) {
        // 1️⃣ Get next highest progress value
        Query query =
            participantsRef.orderBy('totalProgress', descending: true).limit(1);

        if (lastProgress != null) {
          query = query.where('totalProgress', isLessThan: lastProgress);
        }

        final topProgressSnap = await query.get();
        if (topProgressSnap.docs.isEmpty) break; // No more participants

        final topProgressValue =
            topProgressSnap.docs.first['totalProgress'] as int;

        // 2️⃣ Get all participants with that progress value
        final tiedSnap = await participantsRef
            .where('totalProgress', isEqualTo: topProgressValue)
            .get();

        final participants = tiedSnap.docs.map((doc) {
          final data = doc.data();
          return Participant(
            id: doc.id,
            displayName: data['displayName'],
            totalProgress: data['totalProgress'],
          );
        }).toList();

        ranks.add(RankGroup(rank: currentRank, participants: participants));
        currentRank++;
        lastProgress = topProgressValue;
      }

      return ranks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProgress(UpdateProgressParams params) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not signed in");

      final challengeRef =
          firestore.collection('challenges').doc(params.challengeId);
      final participantRef =
          challengeRef.collection('participants').doc(user.uid);

      await firestore.runTransaction((transaction) async {
        final participantSnap = await transaction.get(participantRef);

        if (participantSnap.exists) {
          transaction.set(
            participantRef,
            {
              'totalProgress': FieldValue.increment(10),
            },
            SetOptions(merge: true),
          );
        }
      });
    } catch (e) {
      rethrow;
    }
  }
}
