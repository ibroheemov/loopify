import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyHabitTracker extends StatelessWidget {
  final Habit habit;
  // final void Function(DateTime date) onToggleDate;

  const WeeklyHabitTracker({
    super.key,
    required this.habit,
    // required this.onToggleDate,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    final weekDates =
        List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
        future: habit.goal.enabled
            ? null
            : HabitLogService.getLogsForHabitToday(habit.id),
        builder: (context, snapshot) {
          final completedDates =
              snapshot.data?.map((e) => e.completedAt).toList() ?? [];

          return AppCard(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(maxWidth: 180),
                      child: Text(
                        habit.title,
                        style: textTheme.titleMedium
                            ?.copyWith(color: Helpers.parseColor(habit.color)),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekDates.map((date) {
                    final isCompleted = completedDates.any((d) =>
                        d.year == date.year &&
                        d.month == date.month &&
                        d.day == date.day);

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
                        return _buildWeekday(
                          context: context,
                          date: date,
                          progress: progress,
                          isCompleted: isCompleted,
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildWeekday({
    required BuildContext context,
    required DateTime date,
    required int progress,
    required bool isCompleted,
  }) {
    final isDayApplicable =
        habit.weekdays.selectedWeekDays.contains(date.weekday);
    final isMonday = date.weekday == 1;
    final isSunday = date.weekday == 7;

    return GestureDetector(
      child: Column(
        children: [
          Opacity(
            opacity: isDayApplicable ? 1 : 0.3,
            child: Text(DateFormat.E().format(date)),
          ), // Mon, Tue...
          const SizedBox(height: 4),
          Opacity(
            opacity: isDayApplicable ? 1 : 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (!habit.goal.enabled && isCompleted)
                    ? Helpers.parseColor(habit.color)
                    : progress == 0
                        ? AppColors.of(context).onSurfaceBg
                        : Helpers.parseColor(habit.color)
                            .withOpacity(progress / habit.goal.value),
              ),
              child: (isMonday || isSunday)
                  ? Center(child: Text(date.day.toString()))
                  : Center(
                      child: isCompleted
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 20)
                          : const Icon(Icons.remove,
                              color: Colors.white54, size: 20),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
