import 'package:betterloop/features/statistics/providers/current_habit_provider.dart';
import 'package:betterloop/features/statistics/widgets/stat_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentStreak extends ConsumerStatefulWidget {
  const CurrentStreak({super.key});

  @override
  ConsumerState<CurrentStreak> createState() => _CurrentStreakState();
}

class _CurrentStreakState extends ConsumerState<CurrentStreak> {
  int value = 0;

  Future<void> calculateStreak(Habit habit) async {
    final streak = await HabitLogService.getCurrentMonthStreak(habit);
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
      color: Color(0xFFF63466),
      title: "Current \nstreak",
      value: value.toString(),
      bottomText: "Best streak:",
    );
  }
}
