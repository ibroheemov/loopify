import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/features/custom_habit/providers/goal_provider.dart';
import 'package:betterloop/features/custom_habit/providers/habit_color_provider.dart';
import 'package:betterloop/features/custom_habit/providers/habit_icon_provider.dart';
import 'package:betterloop/features/custom_habit/providers/reminder_provider.dart';
import 'package:betterloop/features/custom_habit/providers/weekdays_provider.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/services/notification_service.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ActionButtons extends ConsumerWidget {
  const ActionButtons(
      {super.key,
      required this.formKey,
      required this.controller,
      this.habitTobeUpdated})
      : isUpdate = habitTobeUpdated != null;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  final bool isUpdate;
  final Habit? habitTobeUpdated;

  @override
  Widget build(BuildContext context, ref) {
    print(isUpdate);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.horizontal),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(
                fixedSize: Size(52, 52),
                padding: EdgeInsets.all(5),
                backgroundColor: AppColors.of(context).backgroundDark),
            iconSize: 30,
            color: AppColors.of(context).textSecondary,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(GeneralIcons.close),
          ),
          SizedBox(width: AppSpacing.sm),
          PrimaryButton(
            isRounded: true,
            label: isUpdate ? "Save habit" : "Create habit",
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              _onCreateHabit(ref);
              Navigator.pop(context, true);
            },
          )
        ],
      ),
    );
  }

  void _onCreateHabit(WidgetRef ref) async {
    final icon = ref.watch(habitIconProvider);
    final iconColor = ref.watch(habitColorProvider);
    final goal = ref.read(goalProvider);
    final reminder = ref.read(reminderProvider);
    final weekdays = ref.read(weekdaysProvider);

    var uuid = Uuid();
    final habitId = uuid.v1();
    final name = controller.text.trim();

    final habit = Habit(
      color: iconColor,
      icon: HiveIcon(code: icon.codePoint, family: icon.fontFamily),
      id: isUpdate ? habitTobeUpdated!.id : habitId,
      title: name,
      createdAt: DateTime.now(),
      goal: goal,
      weekdays: weekdays,
      reminder: reminder,
    );

    if (isUpdate) {
      await HabitService.updateHabit(habit);
    } else {
      await HabitService.addHabit(habit);
    }

    if (!reminder.enabled) return;
    final hash = habitId.hashCode;
    await NotificationService().scheduleNotification(
      notificationId: hash,
      habit: habit,
      notificationItem: NotificationItem(
          timeH: reminder.hour, timeM: reminder.minute, id: 1222),
      weekdayEntities: reminder.selectedWeekDays,
    );
  }
}
