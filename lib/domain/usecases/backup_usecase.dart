import 'package:betterloop/config/failure.dart';
import 'package:betterloop/domain/repositories/user_repository.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

class BackupUsecase extends UseCase<void, NoParams> {
  final UserRepository repository;

  BackupUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.backup();
  }
}
