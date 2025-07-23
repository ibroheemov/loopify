import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_area.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:betterloop/models/habit_type.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/services/notification_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'data/seed/default_habit_areas.dart';
import 'data/seed/default_habit_types.dart';
import 'routes/app_router.dart';
import 'services/habit_area_service.dart';
import 'services/habit_type_service.dart';
import 'services/shared_prefs_service.dart';
import 'theme/theme.dart'; // your custom theme setup

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await NotificationService().initializePlatformNotifications();
  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.requestNotificationsPermission();

  await SharedPrefsService().init();
  final isOnboardingDone = SharedPrefsService().onboardingComplete;
  await Hive.initFlutter();
  // Register adapters
  Hive.registerAdapter(HabitAdapter());
  Hive.registerAdapter(HabitAreaAdapter());
  Hive.registerAdapter(HabitTypeAdapter());
  Hive.registerAdapter(HiveIconAdapter()); // if using enums
  Hive.registerAdapter(HabitLogAdapter());
  Hive.registerAdapter(GoalAdapter());
  Hive.registerAdapter(WeekdaysAdapter());
  Hive.registerAdapter(ReminderAdapter());

  await preloadDefaultHabitTemplates();
  await HabitService.openBox();
  runApp(ProviderScope(
    child: MyApp(
        initialRoute:
            isOnboardingDone ? RouteNames.navigation : RouteNames.welcome),
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

final completed = SharedPrefsService().onboardingComplete;

Future<void> preloadDefaultHabitTemplates() async {
  // HabitAreaService.clearAllAreas();
  // HabitTypeService.clearAllHabitTypes();

  final areas = await HabitAreaService.getAllAreas();
  if (areas.isEmpty) {
    for (var area in defaultHabitAreas) {
      await HabitAreaService.addArea(area);
    }
  }
  final types = await HabitTypeService.getAllHabitTypes();

  if (types.isEmpty) {
    for (var type in defaultHabitTypes) {
      await HabitTypeService.addHabitType(type);
    }
  }
}
