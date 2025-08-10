import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:dartz/dartz.dart';

abstract class ChallengeRepository {
  Future<Either<Failure, List<Challenge>>> getChallenges();
  Future<Either<Failure, void>> joinChallenge(JoinChallengeParams params);
  Future<Either<Failure, void>> leaveChallenge();
}
