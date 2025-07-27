import 'package:betterloop/features/statistics/habit_progress_chart.dart';
import 'package:betterloop/features/statistics/widgets/current_streak.dart';
import 'package:betterloop/theme/spacing.dart';

import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'habits_dropdown.dart';
import 'providers/current_habit_provider.dart';
import 'widgets/average_per_daily.dart';
import 'widgets/completion_rate.dart';
import 'widgets/perfect_days.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          HabitsDropdown(
            onSelected: (habit) async {
              ref.read(currentHabitProvider.notifier).state = habit;
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: AppContainer(
            child: Column(
              children: [
                SizedBox(height: AppSpacing.lg),
                SizedBox(
                  height: 300,
                  child: HabitChartWithDropdown(),
                ),
                SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Expanded(
                      child: CurrentStreak(),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: CompletionRate(),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: PerfectDays(),
                    ),
                    SizedBox(width: 15),
                    // [ TODO ] Consider replacing with total times completed in a month
                    Expanded(
                      child: AveragePerDaily(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
