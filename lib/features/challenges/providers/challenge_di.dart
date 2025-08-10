import 'package:betterloop/data/datasources/challenge_remote_datasource.dart';
import 'package:betterloop/data/repositories/challenge_repository_impl.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/get_challenges.dart';
import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    show Provider, FutureProvider;

final challengeRemoteDataSourceProvider = Provider<ChallengeRemoteDatasource>(
    (ref) => ChallengeRemoteDatasourceImpl());

final challengeRepositoryProvider = Provider<ChallengeRepository>((ref) {
  final repo = ref.watch(challengeRemoteDataSourceProvider);
  return ChallengeRepositoryImpl(repo);
});

final getChallengesUsecaseProvider = Provider<GetChallengesUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return GetChallengesUsecase(repo);
});

final challengesProvider = FutureProvider<List<Challenge>>((ref) async {
  final usecase = ref.read(getChallengesUsecaseProvider);

  final result = await usecase(NoParams());

  return result.fold(
    (failure) => throw failure, // Will show as AsyncError in UI
    (challenges) => challenges,
  );
});
