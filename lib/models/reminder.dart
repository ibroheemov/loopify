import 'package:hive/hive.dart';

part 'reminder.g.dart';

@HiveType(typeId: 8)
class Reminder {
  @HiveField(0)
  final bool enabled;

  @HiveField(1)
  final int hour;

  @HiveField(2)
  final int minute;

  @HiveField(3)
  final List<int> selectedWeekDays;

  Reminder({
    this.enabled = false,
    this.hour = 19,
    this.minute = 0,
    required this.selectedWeekDays,
  });

  factory Reminder.defaultReminder() =>
      Reminder(selectedWeekDays: [1, 2, 3, 4, 5, 6, 7]);

  factory Reminder.toReminder({
    required Reminder reminder,
    bool? enabled,
    int? hour,
    int? minute,
    List<int>? selectedWeekDays,
  }) =>
      Reminder(
        enabled: enabled ?? reminder.enabled,
        hour: hour ?? reminder.hour,
        minute: minute ?? reminder.minute,
        selectedWeekDays: selectedWeekDays ?? reminder.selectedWeekDays,
      );
}
