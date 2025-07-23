import 'package:hive/hive.dart';

part 'habit_area.g.dart';

@HiveType(typeId: 1)
class HabitArea extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String emoji;

  HabitArea({
    required this.id,
    required this.name,
    required this.emoji,
  });
}
