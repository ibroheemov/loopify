import 'package:hive/hive.dart';

class JoinedChallengesService {
  static const String _boxName = 'joinedChallengesBox';

  /// Open the Hive box
  static Future<void> init() async {
    await Hive.openBox<String>(_boxName);
  }

  /// Get box
  Box<String> get _box => Hive.box<String>(_boxName);

  /// Add challenge to joined list
  Future<void> join(String challengeId) async {
    if (!isJoined(challengeId)) {
      await _box.add(challengeId);
    }
  }

  /// Remove challenge from joined list
  Future<void> leave(String challengeId) async {
    final key = _box.keys.firstWhere(
      (k) => _box.get(k) == challengeId,
      orElse: () => null,
    );
    if (key != null) {
      await _box.delete(key);
    }
  }

  /// Check if challenge is joined
  bool isJoined(String challengeId) {
    return _box.values.contains(challengeId);
  }

  /// Get all joined challenge IDs
  List<String> getJoinedIds() {
    return _box.values.toList();
  }

  /// Clear all joined challenges
  Future<void> clear() async {
    await _box.clear();
  }
}
