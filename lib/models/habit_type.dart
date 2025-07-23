import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:hive/hive.dart';

part 'habit_type.g.dart';

@HiveType(typeId: 2)
class HabitType extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String areaId;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final GoalType type;

  @HiveField(4)
  final HiveIcon icon;

  HabitType({
    required this.id,
    required this.areaId,
    required this.title,
    required this.type,
    required this.icon,
  });
}
