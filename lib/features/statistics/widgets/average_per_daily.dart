import 'package:betterloop/features/statistics/providers/current_habit_provider.dart';
import 'package:betterloop/features/statistics/widgets/stat_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AveragePerDaily extends ConsumerStatefulWidget {
  const AveragePerDaily({super.key});

  @override
  ConsumerState<AveragePerDaily> createState() => _AveragePerDailyState();
}

class _AveragePerDailyState extends ConsumerState<AveragePerDaily> {
  double value = 0;

  Future<void> calculateStreak(Habit habit) async {
    final streak =
        await HabitLogService.getAverageDailyProgress(habit, DateTime.now());
    setState(() => value = streak);
  }

  void _listenCurrentHabit() {
    ref.listen<Habit?>(currentHabitProvider, (prev, next) async {
      if (next != null && next != prev) {
        calculateStreak(next);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _listenCurrentHabit();

    return StatCard(
      color: Color(0xFF933DFF),
      title: "Average per \ndaily",
      value: value.toStringAsFixed(2),
      bottomText: "This month",
    );
  }
}
