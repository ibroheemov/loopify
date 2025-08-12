import 'package:betterloop/config/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}

abstract class Params {}

class JoinChallengeParams implements Params {
  final String challengeId;
  final String displayName;

  JoinChallengeParams({
    required this.challengeId,
    required this.displayName,
  });
}
