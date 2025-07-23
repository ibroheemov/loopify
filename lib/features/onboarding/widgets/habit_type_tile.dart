import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_type.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

final colorss = [
  "1B8FFF",
  "10C580",
  "F8BD33",
  "933DFF",
  "FE7450",
  "F63466",
];

class HabitTypeTile extends StatefulWidget {
  final HabitType habitType;
  final int index;
  final String areaId;
  final Function() onTap;

  const HabitTypeTile({
    super.key,
    required this.habitType,
    required this.index,
    required this.areaId,
    required this.onTap,
  });

  @override
  State<HabitTypeTile> createState() => _HabitTypeTileState();
}

class _HabitTypeTileState extends State<HabitTypeTile>
    with SingleTickerProviderStateMixin {
  late String iconColor;
  bool _tapped = false;

  @override
  void initState() {
    iconColor = colorss[widget.index % colorss.length];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      duration: const Duration(milliseconds: 150),
      scale: _tapped ? 0.96 : 1.0,
      curve: Curves.easeInOut,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          // splashFactory: NoSplash.splashFactory,
          onTap: () async {
            setState(() => _tapped = true);
            await Future.delayed(const Duration(milliseconds: 150));
            setState(() => _tapped = false);
            var uuid = Uuid();

            final habit = Habit(
              color: iconColor,
              icon: widget.habitType.icon,
              id: uuid.v1(),
              title: widget.habitType.title,
              createdAt: DateTime.now(),
              goal: Goal.defaultGoal(),
              weekdays: Weekdays.defaultWeekdays(),
            );
            await HabitService.addHabit(habit);
            widget.onTap();
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        widget.habitType.icon.toIconData,
                        color: parseColor(iconColor),
                        size: 35,
                      ),
                      // Container(
                      //   width: 35,
                      //   height: 35,
                      //   child: SvgPicture.asset(
                      //     // 'assets/icons/${widget.habit.icon}.svg',
                      //     'assets/images/icons/bolt.svg',
                      //     colorFilter: ColorFilter.mode(
                      //       parseColor(iconColor),
                      //       BlendMode.srcIn,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.habitType.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Alternate periods of eating and fasting to improve health and metabolism.',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Color parseColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue).withOpacity(1.0);
  }
}
