import 'package:betterloop/features/statistics/widgets/monthly_habit_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthlyHabitTracker extends StatelessWidget {
  final Habit habit;

  const MonthlyHabitTracker({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.mdLg),
        child: AppCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(DateFormat.MMMM().format(now))
                ],
              ),
              SizedBox(height: AppSpacing.sm),
              FutureBuilder<List<DateTime>>(
                future: habit.goal.enabled
                    ? null
                    : HabitLogService.getLogsForHabitInMonth(habit.id, now),
                builder: (context, snapshot) {
                  final loggedDays = snapshot.data ?? [];
                  return SimpleCalendar(loggedDays: loggedDays, habit: habit);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
