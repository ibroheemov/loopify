import 'package:betterloop/models/challenge.dart';
import 'package:hive/hive.dart';

class ChallengeService {
  static const _boxName = 'challenges';

  static Future<Box<Challenge>> _openBox() async {
    return await Hive.openBox<Challenge>(_boxName);
  }

  static Future<void> addAll(List<Challenge> data) async {
    final box = await _openBox();
    await box.addAll(data);
  }

  static Future<List<Challenge>> getAll() async {
    final box = await _openBox();
    return box.values.toList();
  }
}
