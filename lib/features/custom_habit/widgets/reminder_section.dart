import 'package:betterloop/features/custom_habit/providers/reminder_provider.dart';
import 'package:betterloop/features/custom_habit/widgets/choose_weekdays.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ReminderSection extends ConsumerStatefulWidget {
  const ReminderSection({super.key, this.habit});
  final Habit? habit;

  @override
  ConsumerState<ReminderSection> createState() => _ReminderSectionState();
}

class _ReminderSectionState extends ConsumerState<ReminderSection> {
  final expansionController = ExpansibleController();
  int hour = 19;
  int minute = 0;
  bool enabled = false;
  List<WeekDayEntity> selectedWeekDays = [...weekDays];

  @override
  void initState() {
    final habit = widget.habit;
    if (habit != null) {
      enabled = habit.reminder.enabled;
      final weekdayIds = habit.reminder.selectedWeekDays;
      selectedWeekDays =
          weekDays.where((e) => weekdayIds.contains(e.id)).toList();
      hour = habit.reminder.hour;
      minute = habit.reminder.minute;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return AppCard(
      padding: EdgeInsets.all(0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: enabled,
          tilePadding: EdgeInsets.symmetric(horizontal: AppSpacing.mdLg),
          childrenPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm)
              .copyWith(bottom: AppSpacing.mdLg),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: AppColors.of(context).surfaceSecondary,
          ),
          controller: expansionController,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28))),
          minTileHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Reminder".toUpperCase(), style: textTheme.titleMedium),
              Text(
                enabled ? "ON" : "OFF",
                style: textTheme.titleMedium?.copyWith(
                    color: enabled
                        ? colorScheme.primary
                        : AppColors.of(context).surfaceSecondary),
              ),
            ],
          ),
          onExpansionChanged: _onReminderExpanded,
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: CustomCupertinoPicker(
                      initialItem: hour,
                      items: List.generate(24, (val) => val.addZero()),
                      onSelectedItemChanged: _onHourChangedChanged,
                    ),
                  ),
                  Text(":", style: textTheme.headlineMedium),
                  Expanded(
                    child: CustomCupertinoPicker(
                      initialItem: minute,
                      items: List.generate(
                        60,
                        (val) => val.addZero(),
                      ),
                      onSelectedItemChanged: _onMinuteChanged,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: AppSpacing.vertical),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.mdLg),
              child: ChooseWeekdays(
                  selectedWeekDays: selectedWeekDays,
                  onTapWeekDay: _onTapWeekDay),
            )
          ],
        ),
      ),
    );
  }

  void _onHourChangedChanged(int val) {
    final reminder = ref.read(reminderProvider);

    ref.read(reminderProvider.notifier).state =
        Reminder.toReminder(reminder: reminder, hour: val);
  }

  void _onMinuteChanged(int val) {
    final reminder = ref.read(reminderProvider);

    ref.read(reminderProvider.notifier).state =
        Reminder.toReminder(reminder: reminder, minute: val);
  }

  void _onReminderExpanded(bool val) {
    requestpermission();
    setState(() {
      enabled = val;
    });
    final reminder = ref.read(reminderProvider);

    ref.read(reminderProvider.notifier).state =
        Reminder.toReminder(enabled: val, reminder: reminder);
  }

  void requestpermission() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
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
    ref.read(reminderProvider.notifier).state =
        Reminder(selectedWeekDays: selectedWeekDays.map((e) => e.id).toList());
  }
}
