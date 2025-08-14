import 'package:betterloop/data/datasources/challenge_remote_datasource.dart';
import 'package:betterloop/data/repositories/challenge_repository_impl.dart';
import 'package:betterloop/domain/repositories/challenge_repository.dart';
import 'package:betterloop/domain/usecases/get_challenges.dart';
import 'package:betterloop/domain/usecases/get_weekly_leaderboard.dart';
import 'package:betterloop/domain/usecases/isuser_inchallenge_usecase.dart';
import 'package:betterloop/domain/usecases/join_challenge.dart';
import 'package:betterloop/domain/usecases/leave_challenge.dart';
import 'package:betterloop/domain/usecases/update_progress_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show Provider;

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

final joinChallengeUsecaseProvider = Provider<JoinChallengesUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return JoinChallengesUsecase(repo);
});

final leaveChallengeUsecaseProvider = Provider<LeaveChallengesUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return LeaveChallengesUsecase(repo);
});

final isUserInChallengeUsecaseProvider =
    Provider<IsUserInChallengeUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return IsUserInChallengeUsecase(repo);
});

final weeklyLeaderboardUsecaseProvider =
    Provider<GetWeeklyLeaderboardUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return GetWeeklyLeaderboardUsecase(repo);
});

final updateProgressUsecaseProvider = Provider<UpdateProgressUsecase>((ref) {
  final repo = ref.watch(challengeRepositoryProvider);
  return UpdateProgressUsecase(repo);
});
