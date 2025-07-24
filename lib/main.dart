import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/init_serivces.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routes/app_router.dart';
import 'services/shared_prefs_service.dart';
import 'theme/theme.dart'; // your custom theme setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitSerivces().initServices();
  final isOnboardingDone = SharedPrefsService().onboardingComplete;

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(ProviderScope(
    child: MyApp(
      initialRoute:
          isOnboardingDone ? RouteNames.navigation : RouteNames.welcome,
    ),
  ));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      title: 'Habit Tracker',
      debugShowCheckedModeBanner: false,
      theme: appLightTheme,
      darkTheme: appDarkTheme,
      themeMode: ThemeMode.system,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
