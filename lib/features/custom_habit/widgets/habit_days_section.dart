import 'package:betterloop/features/custom_habit/providers/weekdays_provider.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'choose_weekdays.dart';
import 'habit_days_x_days_per_week.dart';

class SectionHabitDays extends ConsumerStatefulWidget {
  const SectionHabitDays({super.key, this.habit});
  final Habit? habit;

  @override
  ConsumerState<SectionHabitDays> createState() => _SectionHabitDaysState();
}

class _SectionHabitDaysState extends ConsumerState<SectionHabitDays> {
  bool isXdaysPerWeek = false;
  List<WeekDayEntity> selectedWeekDays = [...weekDays];
  int xDaysPerWeek = 1;

  void setIsXdaysPerWeek(bool value) {
    setState(() {
      isXdaysPerWeek = value;
    });
  }

  @override
  void initState() {
    final habit = widget.habit;
    if (habit != null) {
      final weekdayIds = habit.weekdays.selectedWeekDays;
      isXdaysPerWeek = habit.weekdays.isXdaysPerWeek;
      selectedWeekDays =
          weekDays.where((e) => weekdayIds.contains(e.id)).toList();
      xDaysPerWeek = habit.weekdays.daysPerWeek;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isXdaysPerWeek)
                Text(
                  "${xDaysPerWeek} day(s)".toUpperCase(),
                  style: TextStyle(
                    // color: theme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (!isXdaysPerWeek)
                Text(
                  _selectedWeekDays(selectedWeekDays.map((e) => e.id).toList())
                      .toUpperCase(),
                  style: TextStyle(
                    // color: theme.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              Row(
                children: [
                  Text("X days/week"),
                  Checkbox(
                    side: BorderSide(
                        color: AppColors.of(context).surfaceSecondary),
                    checkColor: Colors.white,
                    value: isXdaysPerWeek,
                    onChanged: _onCheckboxChanged,
                  ),
                ],
              ),
            ],
          ),
          if (!isXdaysPerWeek)
            ChooseWeekdays(
              selectedWeekDays: selectedWeekDays,
              onTapWeekDay: _onTapWeekDay,
            ),
          if (isXdaysPerWeek)
            XDaysPerWeek(
              isXdaysPerWeek: isXdaysPerWeek,
              setIsXdaysPerWeek: setIsXdaysPerWeek,
              context: context,
              xDaysPerWeek: xDaysPerWeek,
              onTapWeekDate: _onTapWeekDate,
            ),
        ],
      ),
    );
  }

  String _selectedWeekDays(List<int> selectedWeekDays) {
    List<WeekDayEntity> filteredWeekDays =
        weekDays.where((e) => selectedWeekDays.contains(e.id)).toList();
    if (filteredWeekDays.length == 7) return 'EveryDay';

    String text = '';
    for (var day in filteredWeekDays) {
      text += '${day.name.substring(0, 2)}, ';
    }

    return text.trim().substring(0, text.length - 2);
  }

  void _onCheckboxChanged(bool? value) {
    setState(() {
      isXdaysPerWeek = value!;
    });
    final weekdays = ref.read(weekdaysProvider);
    ref.read(weekdaysProvider.notifier).state =
        Weekdays.toWeekdays(weekdays: weekdays, isXdaysPerWeek: value);
  }

  void _onTapWeekDay({
    required bool isSelected,
    required WeekDayEntity currentDay,
  }) {
    final days = [...selectedWeekDays];
    if (isSelected) {
      days.removeWhere((e) => e.id == currentDay.id);
    } else {
      days.add(currentDay);
    }
    if (isSelected && days.isEmpty) return;

    setState(() {
      selectedWeekDays = days;
    });
    ref.read(weekdaysProvider.notifier).state =
        Weekdays(selectedWeekDays: selectedWeekDays.map((e) => e.id).toList());
  }

  void _onTapWeekDate(int current) {
    setState(() {
      xDaysPerWeek = current;
    });
    final weekdays = ref.read(weekdaysProvider);
    ref.read(weekdaysProvider.notifier).state =
        Weekdays.toWeekdays(weekdays: weekdays, daysPerWeek: current);
  }
}
