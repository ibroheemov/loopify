import 'package:betterloop/features/statistics/providers/current_habit_provider.dart';
import 'package:betterloop/features/statistics/widgets/stat_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PerfectDays extends ConsumerStatefulWidget {
  const PerfectDays({super.key});

  @override
  ConsumerState<PerfectDays> createState() => _PerfectDaysState();
}

class _PerfectDaysState extends ConsumerState<PerfectDays> {
  int value = 0;

  Future<void> calculateStreak(Habit habit) async {
    final streak =
        await HabitLogService.getPerfectDaysForMonth(habit, DateTime.now());
    if (!mounted) return;
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
      color: Color(0xFFFE7450),
      title: "Perfect \ndays",
      value: value.toString(),
      bottomText: "This month",
    );
  }
}
