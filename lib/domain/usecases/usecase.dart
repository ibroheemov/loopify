import 'package:betterloop/config/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

abstract class StreamUseCase<T, Params> {
  Stream<Either<Failure, T>> call(Params params);
}

class NoParams {}

abstract class Parameteres {}

class JoinChallengeParams implements Parameteres {
  final String challengeId;
  final String displayName;

  JoinChallengeParams({required this.challengeId, required this.displayName});
}

class UpdateProgressParams implements Parameteres {
  final String challengeId;
  final int progress;

  UpdateProgressParams({required this.challengeId, required this.progress});
}
