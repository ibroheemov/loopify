import 'package:betterloop/config/failure.dart';
import 'package:betterloop/data/datasources/challenge_remote_datasource.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/participant.dart';
import 'package:dartz/dartz.dart';

class ChallengeRepositoryImpl implements ChallengeRepository {
  final ChallengeRemoteDatasource remoteDataSource;

  ChallengeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Challenge>>> getChallenges() async {
    try {
      final val = await remoteDataSource.getChallenges();
      return Right(val);
    } catch (e) {
      return Left(RestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> joinChallenge(params) async {
    try {
      final val = await remoteDataSource.joinChallenge(params);
      return Right(val);
    } catch (e) {
      return Left(RestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> leaveChallenge(params) async {
    try {
      final val = await remoteDataSource.leaveChallenge(params);
      return Right(val);
    } catch (e) {
      return Left(RestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isUserInChallenge(String challengeId) async {
    try {
      final result = await remoteDataSource.isUserInChallenge(challengeId);
      return Right(result);
    } catch (e) {
      return Left(IsUserInChallenge(e.toString()));
    }
  }

  @override
  Stream<Either<Failure, List<RankGroup>>> getWeeklyLeaderboard(
      String challengeId) {
    try {
      return remoteDataSource
          .getWeeklyLeaderboardStream(challengeId)
          .map<Either<Failure, List<RankGroup>>>(
            (ranks) => Right(ranks),
          )
          .handleError(
            (error) => Left(ServerFailure(error.toString())),
          );
    } catch (e) {
      return Stream.value(Left(ServerFailure(e.toString())));
    }
  }

  @override
  Future<Either<Failure, void>> updateProgress(
      UpdateProgressParams params) async {
    try {
      final result = await remoteDataSource.updateProgress(params);
      return Right(result);
    } catch (e) {
      return Left(IsUserInChallenge(e.toString()));
    }
  }
}
