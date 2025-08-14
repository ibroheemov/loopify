import 'package:betterloop/models/participant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show FutureProvider, StreamProvider;

import 'index.dart';

final weeklyLeaderboardProvider =
    StreamProvider.family<List<RankGroup>, String>((ref, challengeId) {
  final usecase = ref.read(weeklyLeaderboardUsecaseProvider);

  // Assuming your usecase returns Stream<Either<Failure, List<RankGroup>>>
  return usecase.call(challengeId).map((result) {
    return result.fold(
      (failure) => throw failure, // AsyncError in UI
      (participants) => participants,
    );
  });
});
