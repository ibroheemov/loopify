import 'package:betterloop/models/goal.dart';
import 'package:hive/hive.dart';

part 'challenge.g.dart';

@HiveType(typeId: 9)
class Challenge {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final Goal goal;

  @HiveField(4)
  final int duration;

  @HiveField(5)
  final bool forMuslims;

  @HiveField(6)
  final String hadithEn;

  @HiveField(7)
  final String hadithAr;

  @HiveField(8)
  final int participants;

  @HiveField(9)
  final String color;

  Challenge({
    required this.id,
    required this.title,
    required this.description,
    required this.goal,
    required this.duration,
    required this.forMuslims,
    required this.participants,
    required this.color,
    this.hadithEn = "",
    this.hadithAr = "",
  });
}
