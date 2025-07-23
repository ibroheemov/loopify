import 'package:flutter/material.dart';
import 'habit_days_box.dart';

class XDaysPerWeek extends StatefulWidget {
  final bool isXdaysPerWeek;
  final void Function(bool value) setIsXdaysPerWeek;
  final Function(int) onTapWeekDate;
  final BuildContext context;
  final int xDaysPerWeek;

  const XDaysPerWeek({
    super.key,
    required this.isXdaysPerWeek,
    required this.setIsXdaysPerWeek,
    required this.xDaysPerWeek,
    required this.onTapWeekDate,
    required this.context,
  });

  @override
  State<XDaysPerWeek> createState() => _XDaysPerWeekState();
}

class _XDaysPerWeekState extends State<XDaysPerWeek> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(0),
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 8,
      shrinkWrap: true,
      crossAxisCount: 7,
      children: List<int>.generate(7, (index) => index + 1).map(
        (value) {
          final isSelected = widget.xDaysPerWeek == value;
          return HabitDaysBox(
            isSelected: isSelected,
            onTap: () => widget.onTapWeekDate(value),
            content: value.toString(),
          );
        },
      ).toList(),
    );
  }
}
