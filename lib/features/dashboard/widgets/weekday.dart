import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class Weekday extends StatelessWidget {
  const Weekday({super.key, required this.habit, required this.date});
  final Habit habit;
  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final isCompleted = HabitLogService.isHabitCompleted(habit.id, date);
    // final progress = HabitLogService.getProgressForHabit(habit.id, date);
    print("Weekday");

    return ValueListenableBuilder(
      valueListenable: HabitLogService.boxListenable, // expose listenable
      builder: (context, Box<HabitLog> box, _) {
        print("Weekday");

        final progress = HabitLogService.getProgressForHabit(habit.id, date);
        return _buildWeekday(
          context: context,
          date: date,
          progress: progress,
          isCompleted: isCompleted,
        );
      },
    );
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
                    : null
                // : Center(
                //     child: isCompleted
                //         ? const Icon(Icons.check,
                //             color: Colors.white, size: 20)
                //         : const Icon(Icons.remove,
                //             color: Colors.white54, size: 20),
                //   ),
                ),
          ),
        ],
      ),
    );
  }
}
