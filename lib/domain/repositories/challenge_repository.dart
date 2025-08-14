import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/participant.dart';
import 'package:dartz/dartz.dart';

abstract class ChallengeRepository {
  Future<Either<Failure, List<Challenge>>> getChallenges();
  Future<Either<Failure, bool>> isUserInChallenge(String challengeId);
  Future<Either<Failure, void>> joinChallenge(JoinChallengeParams params);
  Future<Either<Failure, void>> leaveChallenge(String challengeId);
  Stream<Either<Failure, List<RankGroup>>> getWeeklyLeaderboard(
      String challengeId);
  Future<Either<Failure, void>> updateProgress(UpdateProgressParams params);
}
