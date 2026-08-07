import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/helpers.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitCard extends StatefulWidget {
  const HabitCard({
    super.key,
    required this.habit,
    this.progress,
    this.onComplete,
    this.isComplete = false,
  });
  final Habit habit;
  final int? progress;
  final bool isComplete;
  final void Function()? onComplete;

  @override
  State<HabitCard> createState() => _HabitCardState();
}

class _HabitCardState extends State<HabitCard> with TickerProviderStateMixin {
  late final controller = SlidableController(this);

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;

    return Padding(
      padding: EdgeInsets.only(bottom: habit.goal.enabled ? 0 : AppSpacing.md),
      child: AppCard(
        onTap: () {
          if (habit.isChallenge) {
            Navigator.pushNamed(context, RouteNames.challenge,
                arguments: habit.challenge);
          } else {
            Navigator.pushNamed(context, RouteNames.customHabit,
                arguments: habit);
          }
        },
        margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        padding: EdgeInsets.all(AppSpacing.md),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              buildIcon(habit),
              SizedBox(width: AppSpacing.md),
              buildTitle(),
            ]),
            if (!habit.isChallenge) _builCompletion()
          ],
        ),
      ),
    );
  }

  Widget buildTitle() {
    final habit = widget.habit;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 180),
          child: Text(
            habit.title,
            style: textTheme.titleMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (habit.goal.enabled)
          Row(
            children: [
              if (widget.progress != null)
                Text(
                  "${widget.progress} /",
                  style:
                      textTheme.titleMedium?.copyWith(color: AppColors.accent),
                ),
              Text(
                "${habit.goal.value} ${habit.goal.unit}",
                style: textTheme.titleMedium?.copyWith(color: AppColors.accent),
              ),
            ],
          )
      ],
    );
  }

  Widget buildIcon(Habit habit) {
    return Container(
      width: 55,
      height: 55,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Helpers.parseColor(habit.color).withValues(alpha: 0.2),
      ),
      child: Icon(habit.icon.toIconData,
          color: Helpers.parseColor(habit.color), size: 30),
    );
  }

  Widget _builCompletion() {
    final habit = widget.habit;
    final colorScheme = Theme.of(context).colorScheme;
    final goalEnabled = widget.habit.goal.enabled;

    return goalEnabled
        ? IconButton(
            onPressed: widget.isComplete ? null : widget.onComplete,
            icon: Icon(
              widget.isComplete
                  ? GeneralIcons.checkCircleBold
                  : GeneralIcons.circleOutline,
              size: 35,
              color: widget.isComplete
                  ? colorScheme.primary
                  : AppColors.of(context).surfaceSecondary,
            ),
          )
        : FutureBuilder(
            future: HabitLogService.getLogsForHabitToday(habit.id),
            builder: (context, snapshot) {
              final isCompleted = snapshot.hasData && snapshot.data!.isNotEmpty;

              return IconButton(
                onPressed: () => _onComplete(isCompleted),
                icon: Icon(
                  isCompleted
                      ? GeneralIcons.checkCircleBold
                      : GeneralIcons.circleOutline,
                  size: 35,
                  color: isCompleted
                      ? colorScheme.primary
                      : AppColors.of(context).surfaceSecondary,
                ),
              );
            },
          );
  }

  void _onComplete(bool isCompleted) async {
    final habit = widget.habit;

    if (isCompleted) {
      await HabitLogService.removeLogForToday(habit.id);
      // final date = DateTime.now().add(Duration(days: -9));
      // await HabitLogService.logCompletion(habit, habit.goal.value, date);
    } else {
      await HabitLogService.logCompletion(habit, habit.goal.value);
    }
    setState(() {});
  }
}
