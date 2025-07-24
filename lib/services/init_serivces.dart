import 'package:betterloop/config/auth_config.dart';
import 'package:betterloop/data/seed/default_habit_areas.dart';
import 'package:betterloop/data/seed/default_habit_types.dart';
import 'package:betterloop/firebase_options.dart';
import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_area.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:betterloop/models/habit_type.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:betterloop/services/habit_type_service.dart';
import 'package:betterloop/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'habit_area_service.dart';
import 'shared_prefs_service.dart';

class InitSerivces {
  Future<void> initServices() async {
    await _initNotifications();
    await _initFirebase();
    await _initSharedPrefs();
    await _initHive();
    await preloadDefaultHabitTemplates();
    await HabitService.openBox();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      GoogleProvider(clientId: googleClientId),
    ]);
  }

  Future<void> _initNotifications() async {
    await NotificationService().initializePlatformNotifications();

    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  Future<void> _initSharedPrefs() async {
    await SharedPrefsService().init();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(HabitAdapter());
    Hive.registerAdapter(HabitAreaAdapter());
    Hive.registerAdapter(HabitTypeAdapter());
    Hive.registerAdapter(HiveIconAdapter());
    Hive.registerAdapter(HabitLogAdapter());
    Hive.registerAdapter(GoalAdapter());
    Hive.registerAdapter(WeekdaysAdapter());
    Hive.registerAdapter(ReminderAdapter());
  }

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
}
