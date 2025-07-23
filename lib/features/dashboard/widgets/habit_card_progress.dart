import 'package:betterloop/features/dashboard/widgets/habit_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitCardProgress extends StatefulWidget {
  const HabitCardProgress({super.key, required this.habit});
  final Habit habit;

  @override
  State<HabitCardProgress> createState() => _HabitCardProgressState();
}

class _HabitCardProgressState extends State<HabitCardProgress>
    with TickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: HabitLogService.getProgressForHabit(habit.id),
      builder: (context, snapshot) {
        int progress = 0;
        int completeBy = 0;
        final hasData = snapshot.hasData;
        if (hasData) {
          progress = snapshot.data!;
          completeBy = ((habit.goal.value - progress) / 2).round();
        }
        bool isCompleByOne = completeBy == 1;
        bool isComplete = habit.goal.value == progress;

        return Padding(
          padding: EdgeInsets.only(bottom: AppSpacing.md),
          child: Slidable(
            controller: controller,
            startActionPane: !isComplete
                ? null
                : ActionPane(
                    extentRatio: 0.25,
                    motion: DrawerMotion(),
                    children: [
                      Flexible(
                        child: AppCard(
                            onTap: () {
                              HabitLogService.undoAllProgressForHabitOnDay(
                                  habit.id);
                              controller.close();
                              setState(() {});
                            },
                            color: Helpers.parseColor(habit.color),
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(left: AppSpacing.md),
                            child: Center(
                              child: Text(
                                "Undo",
                                style: textTheme.titleLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  ),
            endActionPane: isComplete
                ? null
                : ActionPane(
                    extentRatio: isCompleByOne ? 0.25 : 0.5,
                    motion: DrawerMotion(),
                    children: [
                      Flexible(
                        child: AppCard(
                            onTap: () {
                              HabitLogService.logCompletion(habit, 1);
                              controller.close();
                              setState(() {});
                            },
                            color: Helpers.parseColor(habit.color),
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(right: AppSpacing.md),
                            child: Center(
                              child: Text(
                                "1+",
                                style: textTheme.displayLarge
                                    ?.copyWith(color: Colors.white),
                              ),
                            )),
                      ),
                      if (!isCompleByOne)
                        Flexible(
                          child: AppCard(
                            onTap: hasData
                                ? () => _onCompleteByX(completeBy)
                                : null,
                            color: Helpers.parseColor(habit.color),
                            padding: EdgeInsets.all(0),
                            margin: EdgeInsets.only(right: AppSpacing.md),
                            child: Center(
                              child: Text(
                                hasData ? "$completeBy+" : "...",
                                style: textTheme.displayMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
            child: HabitCard(
              habit: habit,
              progress: progress,
              isComplete: isComplete,
              onComplete: () {
                HabitLogService.logCompletion(habit, widget.habit.goal.value);
                setState(() {});
              },
            ),
          ),
        );
      },
    );
  }

  void _onCompleteByX(int progress, [isTest = false]) {
    if (isTest) {
      final testCompleteBy = 20;
      final days = 3;
      final date = DateTime.now().add(Duration(days: days));
      HabitLogService.logCompletion(widget.habit, testCompleteBy, date);
      controller.close();
      setState(() {});
    } else {
      HabitLogService.logCompletion(widget.habit, progress);
      controller.close();
      setState(() {});
    }
  }
}
