import 'package:betterloop/services/shared_prefs_service.dart';
import 'package:betterloop/utils/theme_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sharedPrefsProvider = Provider<SharedPrefsService>((ref) {
  return SharedPrefsService();
});

final themeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>(
  (ref) {
    final prefs = ref.watch(sharedPrefsProvider);
    return ThemeModeNotifier(prefs);
  },
);

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  final SharedPrefsService prefs;

  ThemeModeNotifier(this.prefs) : super(prefs.themeMode);

  void setMode(AppThemeMode newMode) {
    state = newMode;
    prefs.setThemeMode(newMode);
  }
}
