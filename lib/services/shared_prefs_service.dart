import 'package:betterloop/utils/theme_extension.dart';
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

  // Keys
  static const _keyThemeMode = 'theme_mode';

  bool get onboardingComplete =>
      _prefs?.getBool(SharedPrefsKeys.onboardingComplete) ?? false;

  Future<void> setOnboardingComplete(bool value) async {
    await _prefs?.setBool(SharedPrefsKeys.onboardingComplete, value);
  }

  String? get userName => _prefs?.getString(SharedPrefsKeys.userName);

  Future<void> setUserName(String name) async {
    await _prefs?.setString(SharedPrefsKeys.userName, name);
  }

  AppThemeMode get themeMode {
    final value = _prefs?.getString(_keyThemeMode);
    return AppThemeModeExt.fromString(value);
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    await _prefs?.setString(_keyThemeMode, mode.name);
  }
}
