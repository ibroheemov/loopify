import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restore_usecase_provider.dart';

class BackupNotifier extends AsyncNotifier<void> {
  bool _hasTriggered = false;

  @override
  Future<void> build() async {
    // No-op (or preload if needed)
  }

  Future<void> backup() async {
    _hasTriggered = true;

    final usecase = ref.read(backupUsecaseProvider);
    state = const AsyncLoading();

    final result = await usecase.call(NoParams());

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }

  bool get hasTriggeredRestore => _hasTriggered;
}

final backupNotifierProvider =
    AsyncNotifierProvider<BackupNotifier, void>(() => BackupNotifier());
