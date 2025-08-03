import 'package:hive/hive.dart';
import '../models/habit.dart';

class HabitService {
  static const _boxName = 'habits';

  static Box<Habit> getHabitBoxSync() {
    return Hive.box<Habit>(_boxName);
  }

  static Future<Box<Habit>> openBox() async {
    return await Hive.openBox<Habit>(_boxName);
  }

  static Future<void> addHabit(Habit habit) async {
    final box = await openBox();
    await box.put(habit.id, habit);
  }

  static Future<void> deleteHabit(String id) async {
    final box = await openBox();
    await box.delete(id);
  }

  static Future<void> updateHabit(Habit habit) async {
    final box = await openBox();
    await box.put(habit.id, habit);
  }

  static Future<List<Habit>> getAllHabits() async {
    final box = await openBox();
    return box.values.toList();
  }

  static Future<Habit?> getHabit(String id) async {
    final box = await openBox();
    return box.get(id);
  }

  static Future<void> clearAllHabits() async {
    final box = await openBox();
    await box.clear();
  }
}
