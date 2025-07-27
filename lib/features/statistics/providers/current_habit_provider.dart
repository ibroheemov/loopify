import 'package:betterloop/models/habit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentHabitProvider = StateProvider<Habit?>((ref) => null);
