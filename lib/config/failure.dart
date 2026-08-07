import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure([this.message = 'Unknown error']);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => message;
}

class BackupFailure extends Failure {
  const BackupFailure([super.message = 'Failed to back up data']);
}

class RestoreFailure extends Failure {
  const RestoreFailure([super.message = 'Failed to restore data']);
}

class IsUserInChallenge extends Failure {
  const IsUserInChallenge([super.message = 'User is not the challenge']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'ServerFailure']);
}
