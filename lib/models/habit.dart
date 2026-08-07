
import 'package:betterloop/constants/lifestyle_icons.dart';
import 'package:betterloop/models/challenge.dart';
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

  @HiveField(9)
  final bool isChallenge;

  @HiveField(10)
  final Challenge? challenge;

  Habit({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.goal,
    required this.weekdays,
    required this.reminder,
    this.challenge,
    this.showcaseview = false,
    this.isChallenge = false,
  });

  factory Habit.fromChallenge(Challenge challenge) {
    return Habit(
      id: challenge.id,
      title: challenge.title,
      icon: HiveIcon(
        code: LifeStyleIcons.stars2.codePoint,
        family: LifeStyleIcons.stars2.fontFamily,
      ),
      color: challenge.color,
      createdAt: DateTime.now(),
      goal: challenge.goal,
      weekdays: Weekdays.defaultWeekdays(),
      reminder: Reminder.defaultReminder(),
      isChallenge: true,
      challenge: challenge,
    );
  }
}
