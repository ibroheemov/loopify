import 'package:betterloop/features/counter/widget/habit_counter.dart';
import 'package:betterloop/models/habit.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key, required this.habit});
  final Habit habit;

  @override
  Widget build(BuildContext context) {
    return HabitCounter(habit: habit);
  }
}
