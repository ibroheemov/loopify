import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/participant.dart';
import 'package:dartz/dartz.dart';

class GetWeeklyLeaderboard extends UseCase<List<Participant>, String> {
  final ChallengeRepository repository;

  GetWeeklyLeaderboard(this.repository);

  @override
  Future<Either<Failure, List<Participant>>> call(params) async {
    return await repository.getWeeklyLeaderboard(params);
  }
}
