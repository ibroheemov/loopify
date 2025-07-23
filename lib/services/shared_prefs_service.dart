import 'package:shared_preferences/shared_preferences.dart';
import '../constants/shared_prefs_keys.dart';

class SharedPrefsService {
  static final SharedPrefsService _instance = SharedPrefsService._internal();

  factory SharedPrefsService() => _instance;

  SharedPrefsService._internal();

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get onboardingComplete =>
      _prefs?.getBool(SharedPrefsKeys.onboardingComplete) ?? false;

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs?.setBool(SharedPrefsKeys.onboardingComplete, value);
  }

  String? get userName => _prefs?.getString(SharedPrefsKeys.userName);

  Future<void> setUserName(String name) async {
    await _prefs?.setString(SharedPrefsKeys.userName, name);
  }

  // Add more getters/setters as needed...
}
