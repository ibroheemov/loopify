import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restore_usecase_provider.dart';

final lastBackupTimeProvider = FutureProvider<Timestamp?>((ref) async {
  final useCase = ref.watch(lastBackupUsecaseProvider);
  final result = await useCase.call(NoParams());

  return result.fold(
    (failure) =>
        throw Exception(failure.message), // or return null / handle differently
    (data) => data,
  );
});
