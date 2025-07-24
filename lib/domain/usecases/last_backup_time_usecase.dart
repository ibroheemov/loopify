import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/user_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

class LastBackupTimeUsecase extends UseCase<Timestamp?, NoParams> {
  final UserRepository repository;

  LastBackupTimeUsecase(this.repository);

  @override
  Future<Either<Failure, Timestamp?>> call(params) async {
    return await repository.lastBackupTime();
  }
}
