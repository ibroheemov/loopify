import 'package:flutter/material.dart';

import 'habit_days_box.dart';

class WeekDayEntity {
  final String name;
  final int id;

  WeekDayEntity({required this.name, required this.id});
}

final List<WeekDayEntity> weekDays = [
  WeekDayEntity(name: 'Monday', id: 1),
  WeekDayEntity(name: 'Tuesday', id: 2),
  WeekDayEntity(name: 'Wednesday', id: 3),
  WeekDayEntity(name: 'Thursday', id: 4),
  WeekDayEntity(name: 'Friday', id: 5),
  WeekDayEntity(name: 'Saturday', id: 6),
  WeekDayEntity(name: 'Sunday', id: 7),
];

class ChooseWeekdays extends StatelessWidget {
  final List<WeekDayEntity> selectedWeekDays;
  final Function({
    required bool isSelected,
    required WeekDayEntity currentDay,
  }) onTapWeekDay;

  const ChooseWeekdays({
    super.key,
    required this.selectedWeekDays,
    required this.onTapWeekDay,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GridView.count(
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          shrinkWrap: true,
          crossAxisCount: 7,
          children: weekDays.map(
            (weekday) {
              final isSelected = selectedWeekDays.contains(weekday);
              return HabitDaysBox(
                isSelected: isSelected,
                onTap: () => onTapWeekDay(
                  isSelected: isSelected,
                  currentDay: weekday,
                ),
                content: weekday.name.substring(0, 1),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}
