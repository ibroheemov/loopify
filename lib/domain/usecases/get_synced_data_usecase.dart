import 'package:apexhabit/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:apexhabit/core/error/failures.dart';
import 'package:apexhabit/core/usecase.dart';

class GetSyncedDataUsecase extends UseCase<void, String> {
  final UserRepository repository;

  GetSyncedDataUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(params) async {
    return await repository.getSyncedData(params);
  }
}
