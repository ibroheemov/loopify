import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'index.dart';

enum ChallengeAction { none, join, leave }

class ChallengeNotifier extends AsyncNotifier<ChallengeAction> {
  bool _hasTriggeredRestore = false;

  @override
  Future<ChallengeAction> build() async {
    // No-op (or preload if needed)
    return ChallengeAction.none;
  }

  Future<void> joinChallenge(JoinChallengeParams params) async {
    _hasTriggeredRestore = true;

    final usecase = ref.read(joinChallengeUsecaseProvider);
    state = const AsyncLoading();

    final result = await usecase.call(params);

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(ChallengeAction.join),
    );
  }

  Future<void> leaveChallenge(String params) async {
    _hasTriggeredRestore = true;

    final usecase = ref.read(leaveChallengeUsecaseProvider);
    state = const AsyncLoading();

    final result = await usecase.call(params);

    result.fold(
      (failure) => state = AsyncError(failure.message, StackTrace.current),
      (_) => state = const AsyncData(ChallengeAction.leave),
    );
  }

  bool get hasTriggeredRestore => _hasTriggeredRestore;
}

final challengeNotifierProvider =
    AsyncNotifierProvider<ChallengeNotifier, ChallengeAction>(
        () => ChallengeNotifier());
