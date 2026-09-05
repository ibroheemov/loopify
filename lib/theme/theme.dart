import 'package:betterloop/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'typography.dart';

final ThemeData appLightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: AppColors.light.background,
  primaryColor: AppColors.primary,
  textTheme: AppTypography.textTheme,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.light.background,
  ),
  fontFamily: 'Nunito',
  colorScheme: ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.light.surface,
    error: AppColors.error,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.light.textPrimary,
    onError: Colors.white,
    outline: AppColors.light.outline,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    foregroundColor: AppColors.light.textPrimary,
    scrolledUnderElevation: 0,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   systemNavigationBarColor: AppColors.light.surface,
    //   systemNavigationBarIconBrightness: Brightness.dark,
    // ),
    actionsPadding: EdgeInsets.only(right: AppSpacing.smMd),
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.transparent,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData().copyWith(
      color: AppColors.primary, linearTrackColor: AppColors.light.outline),
);

final ThemeData appDarkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: AppColors.dark.background,
  primaryColor: AppColors.primary,
  textTheme: AppTypography.textTheme.apply(
    bodyColor: AppColors.dark.textPrimary,
    displayColor: AppColors.dark.textPrimary,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.dark.background,
  ),
  fontFamily: 'Nunito',
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.dark.surface,
    error: AppColors.error,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: AppColors.dark.textPrimary,
    onError: Colors.white,
    outline: AppColors.dark.outline,
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: Colors.red,
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.red,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.dark.background,
    foregroundColor: Colors.white,
    scrolledUnderElevation: 0,
    // systemOverlayStyle: SystemUiOverlayStyle(
    //   systemNavigationBarColor: AppColors.dark.surface,
    //   systemNavigationBarIconBrightness: Brightness.light,
    // ),
    actionsPadding: EdgeInsets.only(right: AppSpacing.smMd),
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData().copyWith(
      color: AppColors.primary, linearTrackColor: AppColors.dark.outline),
);
