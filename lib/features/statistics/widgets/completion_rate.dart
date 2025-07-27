import 'package:betterloop/features/statistics/providers/current_habit_provider.dart';
import 'package:betterloop/features/statistics/widgets/stat_card.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CompletionRate extends ConsumerStatefulWidget {
  const CompletionRate({super.key});

  @override
  ConsumerState<CompletionRate> createState() => _CompletionRateState();
}

class _CompletionRateState extends ConsumerState<CompletionRate> {
  double value = 0;

  Future<void> calculateStreak(Habit habit) async {
    final streak =
        await HabitLogService.getMonthlyCompletionRate(habit, DateTime.now());
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
      color: Color(0xFF84CC16),
      title: "Completion \nrate",
      value: '${value.floor()}%',
      bottomText: "This month",
    );
  }
}
