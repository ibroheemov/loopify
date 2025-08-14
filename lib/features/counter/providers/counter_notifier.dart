import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/features/challenges/providers/index.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends AsyncNotifier<void> {
  bool _hasTriggeredRestore = false;

  @override
  Future<void> build() async {
    // No-op (or preload if needed)
  }

  Future<void> updateProgress(UpdateProgressParams params) async {
    _hasTriggeredRestore = true;

    final usecase = ref.read(updateProgressUsecaseProvider);
    state = const AsyncLoading();

    final result = await usecase.call(params);

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(null),
    );
  }

  bool get hasTriggeredRestore => _hasTriggeredRestore;
}

final counterNotifierProvider =
    AsyncNotifierProvider<CounterNotifier, void>(() => CounterNotifier());
