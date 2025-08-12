import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show FutureProvider;

import 'index.dart';

final challengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final usecase = ref.read(getChallengesUsecaseProvider);

  final result = await usecase(NoParams());

  return result.fold(
    (failure) => throw failure, // Will show as AsyncError in UI
    (challenges) => challenges,
  );
});
