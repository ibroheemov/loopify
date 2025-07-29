import 'package:betterloop/features/statistics/widgets/monthly_habit_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';

class MonthlyHabitTracker extends StatelessWidget {
  final Habit habit;

  const MonthlyHabitTracker({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.md_lg),
        child: AppCard(
          child: FutureBuilder<List<DateTime>>(
            future: habit.goal.enabled
                ? null
                : HabitLogService.getLogsForHabitInMonth(habit.id, now),
            builder: (context, snapshot) {
              final loggedDays = snapshot.data ?? [];
              return SimpleCalendar(loggedDays: loggedDays, habit: habit);
            },
          ),
        ),
      ),
    );
  }
}
