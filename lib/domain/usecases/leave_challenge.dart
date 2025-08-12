import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class LeaveChallengesUsecase extends UseCase<void, String> {
  final ChallengeRepository repository;

  LeaveChallengesUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.leaveChallenge(params);
  }
}
