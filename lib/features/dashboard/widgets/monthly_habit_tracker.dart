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
            future: HabitLogService.getLogsForHabitInMonth(habit.id, now),
            builder: (context, snapshot) {
              final loggedDays = snapshot.data ?? [];

              return GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: daysInMonth,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 10,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final date = DateTime(now.year, now.month, day);

                  final isCompleted = loggedDays.any((log) =>
                      log.year == date.year &&
                      log.month == date.month &&
                      log.day == date.day);

                  return FutureBuilder(
                    future: habit.goal.enabled
                        ? HabitLogService.getProgressForHabit(habit.id, date)
                        : null,
                    builder: (context, snapshot) {
                      int progress = 0;
                      final hasData = snapshot.hasData;
                      if (hasData) {
                        progress = snapshot.data!;
                      }
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: (!habit.goal.enabled && isCompleted)
                              ? Helpers.parseColor(habit.color)
                              : progress == 0
                                  ? AppColors.of(context).onSurfaceBg
                                  : Helpers.parseColor(habit.color)
                                      .withOpacity(progress / habit.goal.value),
                        ),
                        alignment: Alignment.center,
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
