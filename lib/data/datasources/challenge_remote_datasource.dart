import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/goal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ChallengeRemoteDatasource {
  Future<List<Challenge>> getChallenges();
  Future<void> joinChallenge(JoinChallengeParams params);
}

class ChallengeRemoteDatasourceImpl extends ChallengeRemoteDatasource {
  final FirebaseFirestore firestore;

  ChallengeRemoteDatasourceImpl({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Challenge>> getChallenges() async {
    try {
      final snapshot = await firestore.collection('challenges').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        return Challenge(
          title: data['title'] as String,
          description: data['description'] as String,
          duration: data['duration'] as int,
          goal: Goal.fromJson(data['goal']),
          forMuslims: data['forMuslims'] as bool,
          hadith_ar: data['hadith_ar'] as String,
          hadith_en: data['hadith_en'] as String,
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to fetch challenges: $e');
    }
  }

  @override
  Future<void> joinChallenge(params) async {
    final challengeRef =
        firestore.collection('challenges').doc(params.challengeId);
    final participantRef =
        challengeRef.collection('participants').doc(params.userId);

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
          'totalParticipants': FieldValue.increment(1),
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
}
