import 'package:betterloop/data/datasources/user_remote_datasource.dart';
import 'package:betterloop/data/repositories/user_repository_impl.dart';
import 'package:betterloop/domain/repositories/user_repository.dart';
import 'package:betterloop/domain/usecases/backup_usecase.dart';
import 'package:betterloop/domain/usecases/last_backup_time_usecase.dart';
import 'package:betterloop/domain/usecases/restore_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRemoteDataSourceProvider =
    Provider<UserRemoteDatasource>((ref) => UserRemoteDatasourceImpl());

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final repo = ref.watch(userRemoteDataSourceProvider);
  return UserRepositoryImpl(repo);
});

final restoreUsecaseProvider = Provider<RestoreUsecase>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return RestoreUsecase(repo);
});

final backupUsecaseProvider = Provider<BackupUsecase>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return BackupUsecase(repo);
});

final lastBackupUsecaseProvider = Provider<LastBackupTimeUsecase>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return LastBackupTimeUsecase(repo);
});
