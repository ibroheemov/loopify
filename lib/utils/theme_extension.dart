import 'package:flutter/material.dart';

enum AppThemeMode {
  system('system'),
  light('light'),
  dark('dark');

  const AppThemeMode(String value);
}

extension AppThemeModeExt on AppThemeMode {
  String get name => toString().split('.').last;

  ThemeMode get themeMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  static AppThemeMode fromString(String? value) {
    switch (value) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      case 'system':
      default:
        return AppThemeMode.system;
    }
  }
}
