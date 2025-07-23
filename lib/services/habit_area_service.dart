import 'package:hive/hive.dart';
import '../models/habit_area.dart';

class HabitAreaService {
  static const _boxName = 'habit_areas';

  static Future<Box<HabitArea>> _openBox() async {
    return await Hive.openBox<HabitArea>(_boxName);
  }

  static Future<void> addArea(HabitArea area) async {
    final box = await _openBox();
    await box.put(area.id, area);
  }

  static Future<List<HabitArea>> getAllAreas() async {
    final box = await _openBox();
    return box.values.toList();
  }

  static Future<void> clearAllAreas() async {
    final box = await _openBox();
    await box.clear();
  }
}
