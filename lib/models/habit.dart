import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:hive/hive.dart';
part 'habit.g.dart';

@HiveType(typeId: 3)
class Habit extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final HiveIcon icon;

  @HiveField(3)
  final String color;

  @HiveField(4)
  final DateTime createdAt;

  @HiveField(5)
  final Goal goal;

  @HiveField(6)
  final Weekdays weekdays;

  @HiveField(7)
  final Reminder reminder;

  @HiveField(8)
  final bool showcaseview;

  Habit({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.goal,
    required this.weekdays,
    required this.reminder,
    this.showcaseview = false,
  });
}
