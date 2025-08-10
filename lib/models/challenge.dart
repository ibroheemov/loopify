import 'package:betterloop/models/goal.dart';

class Challenge {
  final String title;

  final String description;

  final Goal goal;

  final int duration;

  final bool forMuslims;

  final String hadith_en;

  final String hadith_ar;

  Challenge({
    required this.title,
    required this.description,
    required this.goal,
    required this.duration,
    required this.forMuslims,
    this.hadith_en = "",
    this.hadith_ar = "",
  });
}
