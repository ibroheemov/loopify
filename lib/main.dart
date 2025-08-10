import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/init_serivces.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/utils/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/settings/providers/theme_provider.dart';
import 'routes/app_router.dart';
import 'services/shared_prefs_service.dart';
import 'theme/theme.dart'; // your custom theme setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await InitSerivces().initServices();
  final isOnboardingDone = SharedPrefsService().onboardingComplete;

  runApp(ProviderScope(
    overrides: [
      sharedPrefsProvider.overrideWithValue(SharedPrefsService()),
    ],
    child: MyApp(
      initialRoute: isOnboardingDone ? RouteNames.home : RouteNames.welcome,
    ),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  final String initialRoute;

  const MyApp({
    super.key,
    required this.initialRoute,
  });

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final appTheme = ref.watch(themeProvider);
    final isDark = appTheme.themeMode == ThemeMode.dark;

    print(appTheme.themeMode);

    final systemUiStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: isDark ? AppColors.dark.surface : Colors.white,
      systemNavigationBarIconBrightness:
          isDark ? Brightness.light : Brightness.dark,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiStyle,
      child: MaterialApp(
        // showPerformanceOverlay: true,
        title: 'Habit Tracker',
        debugShowCheckedModeBanner: false,
        theme: appLightTheme,
        darkTheme: appDarkTheme,
        themeMode: appTheme.themeMode,
        initialRoute: widget.initialRoute,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
