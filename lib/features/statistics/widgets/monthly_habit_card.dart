import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SimpleCalendar extends StatefulWidget {
  final List<DateTime> loggedDays;
  final Habit habit;

  const SimpleCalendar(
      {super.key, required this.loggedDays, required this.habit});

  @override
  State<SimpleCalendar> createState() => _SimpleCalendarState();
}

class _SimpleCalendarState extends State<SimpleCalendar> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    int daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);

    // Make Monday the first day of the week
    int startWeekday = firstDayOfMonth.weekday; // 1 = Monday, 7 = Sunday

    List<TableRow> rows = [];

    // Header row
    rows.add(
      TableRow(
        children: List.generate(7, (index) {
          return Padding(
            padding: const EdgeInsets.all(6.0),
            child: Center(
              child: Text(
                DateFormat.E()
                    .format(DateTime(2020, 1, index + 6)), // Mon to Sun
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          );
        }),
      ),
    );

    // Fill in the calendar days
    List<Widget> currentRow = [];
    int day = 1;

    // Fill initial empty cells
    for (int i = 1; i < startWeekday; i++) {
      currentRow.add(Container());
    }

    // Add days of the month
    while (day <= daysInMonth) {
      // print(day);
      final thisDay = day;
      final date = DateTime(now.year, now.month, day);
      final isDayApplicable =
          widget.habit.weekdays.selectedWeekDays.contains(date.weekday);

      currentRow.add(
        !isDayApplicable
            ? Container(
                width: 30,
                height: 30,
                margin: EdgeInsets.only(bottom: 5),
              )
            : FutureBuilder(
                future: widget.habit.goal.enabled
                    ? HabitLogService.getProgressForHabit(widget.habit.id, date)
                    : null,
                builder: (context, snapshot) {
                  int progress = 0;
                  final hasData = snapshot.hasData;
                  if (hasData) {
                    progress = snapshot.data!;
                  }
                  return Center(
                    child: Container(
                      width: 30,
                      height: 30,
                      margin: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: boxColor(day: thisDay, progress: progress),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$thisDay',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
      );

      if (currentRow.length == 7) {
        rows.add(TableRow(children: List.from(currentRow)));
        currentRow.clear();
      }
      print(day);

      day++;
    }

    // Fill remaining empty cells at the end
    if (currentRow.isNotEmpty) {
      while (currentRow.length < 7) {
        currentRow.add(Container());
      }
      rows.add(TableRow(children: currentRow));
    }

    return Table(
      // border: TableBorder.all(color: Colors.grey.shade300),
      children: rows,
    );
  }

  Color boxColor({required int day, required int progress}) {
    // print(day);
    DateTime now = DateTime.now();

    final goalEnabled = widget.habit.goal.enabled;
    if (!goalEnabled) {
      final date = DateTime(now.year, now.month, day);

      final isCompleted = widget.loggedDays.any((log) =>
          log.year == date.year &&
          log.month == date.month &&
          log.day == date.day);

      return isCompleted
          ? Helpers.parseColor(widget.habit.color)
          : AppColors.of(context).onSurfaceBg;
    } else {
      return progress == 0
          ? AppColors.of(context).onSurfaceBg
          : Helpers.parseColor(widget.habit.color)
              .withOpacity(progress / widget.habit.goal.value);
    }
  }
}
