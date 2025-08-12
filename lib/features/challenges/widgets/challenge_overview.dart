import 'package:betterloop/features/challenges/providers/isuser_joined_provider.dart';
import 'package:betterloop/features/dashboard/widgets/weekly_habit_tracker.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChallengeOverview extends ConsumerStatefulWidget {
  const ChallengeOverview({super.key, required this.challenge});
  final Challenge challenge;

  @override
  ConsumerState<ChallengeOverview> createState() => _ChallengeOverviewState();
}

class _ChallengeOverviewState extends ConsumerState<ChallengeOverview> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final challenge = widget.challenge;
    final isJoined = ref.watch(isUserJoinedProvider);

    return isJoined
        ? WeeklyHabitTracker(habit: Habit.fromChallenge(challenge))
        : AppCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  challenge.title,
                  style: textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.lg),
                // Stats row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem("Goal", challenge.goal.value.toString(),
                        Icons.help_outline),
                    Container(
                      height: 50,
                      width: 2,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).surfaceSecondary,
                      ),
                    ),
                    _buildStatItem("Duration", "${challenge.duration} days",
                        Icons.medication),
                    Container(
                      height: 50,
                      width: 2,
                      decoration: BoxDecoration(
                        color: AppColors.of(context).surfaceSecondary,
                      ),
                    ),
                    _buildStatItem("People", challenge.participants.toString(),
                        Icons.scale),
                  ],
                ),
              ],
            ),
          );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.accent),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
              color: AppColors.of(context).textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}
