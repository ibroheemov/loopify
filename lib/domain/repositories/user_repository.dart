import 'package:betterloop/config/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, void>> restore();
  Future<Either<Failure, void>> backup();
  Future<Either<Failure, Timestamp?>> lastBackupTime();
}
