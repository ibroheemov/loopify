import 'package:betterloop/config/failure.dart';
import 'package:betterloop/data/datasources/user_remote_datasource.dart';
import 'package:betterloop/domain/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDatasource userRemoteDataSource;

  UserRepositoryImpl(this.userRemoteDataSource);

  @override
  Future<Either<Failure, void>> backup() async {
    try {
      await userRemoteDataSource.backup();
      return Right(null);
    } catch (e) {
      return Left(BackupFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> restore() async {
    try {
      await userRemoteDataSource.restore();
      return Right(null);
    } catch (e) {
      return Left(RestoreFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Timestamp?>> lastBackupTime() async {
    try {
      final val = await userRemoteDataSource.lastBackupTime();
      return Right(val);
    } catch (e) {
      return Left(RestoreFailure(e.toString()));
    }
  }
}
