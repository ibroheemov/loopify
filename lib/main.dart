import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/init_serivces.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/utils/theme_extension.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
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
  await _initCrashlytics();
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

Future<void> _initCrashlytics() async {
  await FirebaseCrashlytics.instance
      .setCrashlyticsCollectionEnabled(!kDebugMode);

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
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
