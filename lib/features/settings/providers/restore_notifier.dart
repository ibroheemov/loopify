import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'restore_usecase_provider.dart';

class RestoreNotifier extends AsyncNotifier<void> {
  bool _hasTriggeredRestore = false;

  @override
  Future<void> build() async {
    // No-op (or preload if needed)
  }

  Future<void> restore() async {
    _hasTriggeredRestore = true;

    final usecase = ref.read(restoreUsecaseProvider);
    state = const AsyncLoading();

    final result = await usecase.call(NoParams());

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }

  bool get hasTriggeredRestore => _hasTriggeredRestore;
}

final restoreNotifierProvider =
    AsyncNotifierProvider<RestoreNotifier, void>(() => RestoreNotifier());
