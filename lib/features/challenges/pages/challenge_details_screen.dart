import 'package:betterloop/features/challenges/providers/isuser_joined_provider.dart';
import 'package:betterloop/features/challenges/providers/join_challenge_notifier.dart';
import 'package:betterloop/features/challenges/widgets/challenge_description.dart';
import 'package:betterloop/features/challenges/widgets/challenge_overview.dart';
import 'package:betterloop/features/challenges/widgets/join_button.dart';
import 'package:betterloop/features/challenges/widgets/leave_button.dart';
import 'package:betterloop/features/counter/widget/habit_counter.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/services/joined_challenges_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:betterloop/widgets/app_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ChallengeTabs { counter, description, leaderboard }

class ChallengeDetailsScreen extends ConsumerStatefulWidget {
  const ChallengeDetailsScreen({super.key, required this.challenge});
  final Challenge challenge;

  @override
  ConsumerState<ChallengeDetailsScreen> createState() =>
      _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends ConsumerState<ChallengeDetailsScreen>
    with TickerProviderStateMixin {
  late final TabController _tabControllerWithCounter;
  late final TabController _tabControllerWithoutCounter;
  Habit? habit;

  @override
  void initState() {
    super.initState();
    _tabControllerWithCounter = TabController(length: 3, vsync: this);
    _tabControllerWithoutCounter = TabController(length: 2, vsync: this);
  }

  void setHabit() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Set it only once to avoid repeated updates
    Future.microtask(() {
      final isJoined = JoinedChallengesService().isJoined(widget.challenge.id);
      ref.read(isUserJoinedProvider.notifier).state = isJoined;
    });
  }

  Future<void> createHabit() async {
    final challenge = widget.challenge;

    await HabitService.addHabit(Habit.fromChallenge(challenge));
    await JoinedChallengesService().join(challenge.id);
  }

  Future<void> removeHabit() async {
    final challenge = widget.challenge;

    await HabitService.deleteHabit(challenge.id);
    await JoinedChallengesService().leave(challenge.id);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final challenge = widget.challenge;
    final isJoined = ref.watch(isUserJoinedProvider);

    final controller =
        isJoined ? _tabControllerWithCounter : _tabControllerWithoutCounter;

    listenForNotifier();

    return Scaffold(
      appBar: AppBar(
        actions: [LeaveButton(challenge: challenge)],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: JoinButton(challenge: challenge),
      body: SafeArea(
        child: AppContainer(
          child: Column(
            children: [
              ChallengeOverview(challenge: challenge),
              SizedBox(height: AppSpacing.lg),
              AppTabBar(controller: controller, tabs: _buildTabs()),
              SizedBox(height: AppSpacing.lg),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: _buildTabViews(),
                ),
              )
              //
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTabViews() {
    return _visibleTabs().map((tab) {
      switch (tab) {
        case ChallengeTabs.counter:
          return HabitCounter(habit: Habit.fromChallenge(widget.challenge));
        case ChallengeTabs.description:
          return ChallengeDescription(challenge: widget.challenge);
        case ChallengeTabs.leaderboard:
          return Center(child: Text("Leaderboard"));
      }
    }).toList();
  }

  List<ChallengeTabs> _visibleTabs() {
    final isJoined = ref.watch(isUserJoinedProvider);

    return isJoined
        ? ChallengeTabs.values
        : ChallengeTabs.values
            .where((tab) => tab != ChallengeTabs.counter)
            .toList();
  }

  List<Widget> _buildTabs() {
    return _visibleTabs()
        .map(((e) => Tab(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.horizontal),
                child: Center(child: Text(e.name.capitalize())),
              ),
            )))
        .toList();
  }

  void listenForNotifier() {
    ref.listen<AsyncValue<ChallengeAction>>(challengeNotifierProvider,
        (prev, next) {
      final notifier = ref.read(challengeNotifierProvider.notifier);
      if (!notifier.hasTriggeredRestore) return;

      next.whenOrNull(
        data: (action) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(action.name)));
          if (action == ChallengeAction.join) {
            createHabit();
            ref.read(isUserJoinedProvider.notifier).state = true;
          } else if (action == ChallengeAction.leave) {
            removeHabit();
            ref.read(isUserJoinedProvider.notifier).state = false;
          }
        },
        error: (error, _) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    });
  }
}
