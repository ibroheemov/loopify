import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/participant.dart';
import 'package:dartz/dartz.dart';

class GetWeeklyLeaderboardUsecase
    extends StreamUseCase<List<RankGroup>, String> {
  final ChallengeRepository repository;

  GetWeeklyLeaderboardUsecase(this.repository);

  @override
  Stream<Either<Failure, List<RankGroup>>> call(params) {
    return repository.getWeeklyLeaderboard(params);
  }
}
