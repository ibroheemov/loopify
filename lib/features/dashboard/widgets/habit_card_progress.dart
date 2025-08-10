import 'package:betterloop/constants/lifestyle_icons.dart';
import 'package:betterloop/features/dashboard/widgets/habit_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/services/habit_service.dart';
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
  late SlidableController controller;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    controller = SlidableController(this);
    if (widget.habit.showcaseview) {
      _performShowcaseview();
    }
  }

  void _performShowcaseview() {
    Future.delayed(Duration(seconds: 1), () {
      _openEndActions();
    });
  }

  void _openStartActions() async {
    await controller.openStartActionPane();
    await Future.delayed(Duration(milliseconds: 500), () {
      _undo();
    });
    setState(() {
      opacity = 0.0;
    });
    await Future.delayed(Duration(milliseconds: 700), () async {
      await HabitService.deleteHabit(widget.habit.id);
      await HabitLogService.deleteLogsForHabit(widget.habit.id);
      setState(() {});
    });
  }

  void _openEndActions() async {
    await controller.openEndActionPane();
    await Future.delayed(Duration(seconds: 1), () {
      _onCompleteByX(widget.habit.goal.value);
      _close();
    });
    await Future.delayed(Duration(seconds: 1), () {
      _openStartActions();
    });
  }

  void _close() {
    controller.close();
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final showCounter = habit.goal.unit == "Times";
    final textTheme = Theme.of(context).textTheme;

    return AnimatedOpacity(
      duration: Duration(milliseconds: 700),
      opacity: opacity,
      child: FutureBuilder(
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
                              onTap: _undo,
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
                      extentRatio: showCounter
                          ? 0.75
                          : isCompleByOne
                              ? 0.25
                              : 0.5,
                      motion: DrawerMotion(),
                      children: [
                        Flexible(
                          child: AppCard(
                              disabled: habit.showcaseview,
                              onTap: () => _onCompleteByOne(habit),
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
                              disabled: habit.showcaseview,
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
                          ),
                        if (showCounter)
                          Flexible(
                            child: AppCard(
                              onTap: () {
                                controller.close();
                                Navigator.pushNamed(context, RouteNames.counter,
                                        arguments: habit)
                                    .then((_) {
                                  setState(() {});
                                });
                              },
                              color: Helpers.parseColor(habit.color),
                              padding: EdgeInsets.all(0),
                              margin: EdgeInsets.only(right: AppSpacing.md),
                              child: Center(
                                child: Icon(LifeStyleIcons.clock, size: 35),
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
                  HabitLogService.logCompletion(
                      habit, widget.habit.goal.value - progress);
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _undo() {
    HabitLogService.undoAllProgressForHabitOnDay(widget.habit.id);
    controller.close();
    setState(() {});
  }

  void _onCompleteByOne(Habit habit, [isTest = false]) {
    if (isTest) {
      _onCompleteByX(1);
    } else {
      HabitLogService.logCompletion(habit, 1);
      controller.close();
      setState(() {});
    }
  }

  void _onCompleteByX(int progress, [isTest = false]) {
    if (isTest) {
      final testCompleteBy = 7;
      final days = 17;
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
