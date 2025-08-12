import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:dartz/dartz.dart';

class IsUserInChallengeUsecase {
  final ChallengeRepository repository;

  IsUserInChallengeUsecase(this.repository);

  Future<Either<Failure, bool>> call(String params) {
    return repository.isUserInChallenge(params);
  }
}
