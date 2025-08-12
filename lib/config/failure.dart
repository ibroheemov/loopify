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
  const BackupFailure([String message = 'Failed to back up data'])
      : super(message);
}

class RestoreFailure extends Failure {
  const RestoreFailure([String message = 'Failed to restore data'])
      : super(message);
}

class IsUserInChallenge extends Failure {
  const IsUserInChallenge([String message = 'User is not the challenge'])
      : super(message);
}
