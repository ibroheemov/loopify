import 'package:hive/hive.dart';
import '../models/habit_type.dart';

class HabitTypeService {
  static const _boxName = 'habit_types';

  static Future<Box<HabitType>> _openBox() async {
    return await Hive.openBox<HabitType>(_boxName);
  }

  static Future<void> addHabitType(HabitType habitType) async {
    final box = await _openBox();
    await box.put(habitType.id, habitType);
  }

  static Future<List<HabitType>> getTypesForArea(String areaId) async {
    final box = await _openBox();
    return box.values.where((type) => type.areaId == areaId).toList();
  }

  static Future<List<HabitType>> getAllHabitTypes() async {
    final box = await _openBox();
    return box.values.toList();
  }

  static Future<void> clearAllHabitTypes() async {
    final box = await _openBox();
    await box.clear();
  }
}
