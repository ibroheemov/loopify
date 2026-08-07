import 'package:betterloop/features/dashboard/widgets/weekday.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';

class WeeklyHabitTracker extends StatelessWidget {
  final Habit habit;

  const WeeklyHabitTracker({
    super.key,
    required this.habit,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return AppCard(
      child: Column(
        children: [
          _buildHeader(textTheme),
          SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekDates().map((date) {
              return Weekday(habit: habit, date: date);
            }).toList(),
          ),
        ],
      ),
    );
  }

  List<DateTime> weekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
    final weekDates =
        List.generate(7, (i) => startOfWeek.add(Duration(days: i)));
    return weekDates;
  }

  Widget _buildHeader(TextTheme textTheme) {
    return Row(
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
    );
  }
}
