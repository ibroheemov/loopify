import 'dart:io';

import 'package:betterloop/config/auth_config.dart';
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
import 'package:betterloop/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'shared_prefs_service.dart';

class InitSerivces {
  Future<void> initServices() async {
    await _initNotifications();
    await initPlatformState();
    await _initFirebase();
    await _initSharedPrefs();
    await _initHive();
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

  Future<void> initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.info);

    PurchasesConfiguration configuration;
    if (Platform.isAndroid) {
      configuration =
          PurchasesConfiguration("goog_tyGrHyGYhkPeUUJnfleSJfPUEUy");
    } else if (Platform.isIOS) {
      configuration =
          PurchasesConfiguration("<revenuecat_project_apple_api_key>");
    } else {
      configuration =
          PurchasesConfiguration("goog_tyGrHyGYhkPeUUJnfleSJfPUEUy");
    }
    await Purchases.configure(configuration);
  }
}
