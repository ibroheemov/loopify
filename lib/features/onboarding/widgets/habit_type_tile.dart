import 'package:betterloop/data/seed/default_habit_types.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_svg.dart';
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
  final OnboardingHabit habitType;
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
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      height: 80,
      margin: EdgeInsets.only(bottom: AppSpacing.smMd),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 150),
        scale: _tapped ? 0.96 : 1.0,
        curve: Curves.easeInOut,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          onPressed: () async {
            setState(() => _tapped = true);
            await Future.delayed(const Duration(milliseconds: 150));
            setState(() => _tapped = false);
            var uuid = Uuid();

            final habit = Habit(
              color: iconColor,
              icon: HiveIcon(
                code: widget.habitType.icon.codePoint,
                family: widget.habitType.icon.fontFamily,
              ),
              id: uuid.v1(),
              title: widget.habitType.title,
              createdAt: DateTime.now(),
              goal: widget.habitType.goal,
              weekdays: Weekdays.defaultWeekdays(),
              reminder: Reminder.defaultReminder(),
            );
            await HabitService.addHabit(habit);
            await HabitService.addHabit(showcaseViewHabit);
            widget.onTap();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Helpers.parseColor(iconColor).withAlpha(50)),
                    child: Center(
                      child: Icon(
                        widget.habitType.icon,
                        color: Helpers.parseColor(iconColor),
                        size: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: AppSpacing.horizontal),
                  Container(
                    constraints: BoxConstraints(maxWidth: 170),
                    child: Text(
                      widget.habitType.title,
                      style: textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              AppSvg(
                path: "assets/images/icons/alt-arrow-right.svg",
                width: 30,
                height: 30,
                color: colorScheme.onSurface,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
