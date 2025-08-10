import 'package:betterloop/config/failure.dart';
import 'package:betterloop/data/datasources/challenge_remote_datasource.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/models/challenge.dart';
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
  Future<Either<Failure, void>> leaveChallenge() {
    // TODO: implement leaveChallenge
    throw UnimplementedError();
  }
}
