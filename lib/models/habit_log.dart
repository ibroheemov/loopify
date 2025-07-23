import 'package:hive/hive.dart';
part 'habit_log.g.dart';

@HiveType(typeId: 4)
class HabitLog extends HiveObject {
  @HiveField(0)
  final String habitId;

  @HiveField(1)
  final DateTime completedAt;

  @HiveField(2)
  final int progress;

  HabitLog({
    required this.habitId,
    required this.completedAt,
    required this.progress,
  });
}
