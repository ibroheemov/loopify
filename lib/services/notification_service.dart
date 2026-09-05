import 'dart:io';

import 'package:betterloop/config/notification_setup.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/services/habit_notification_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationItem {
  int id;
  int timeH;
  int timeM;
  List<int> repeat;
  bool status;

  NotificationItem({
    this.id = 0,
    this.status = true,
    this.timeH = 0,
    this.timeM = 0,
    this.repeat = const [1, 2, 3, 4, 5, 6, 7],
  });
}

class NotificationService {
  NotificationService();

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initializePlatformNotifications() async {
    if (Platform.isAndroid) await NotificationSetup.createNotificationChannel();
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation(
        await FlutterTimezone.getLocalTimezone(),
      ),
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(initializationSettings);
  }

  Future<void> scheduleNotification({
    required int notificationId,
    required Habit habit,
    required NotificationItem notificationItem,
    required List<int> weekdayEntities,
  }) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_notification',
      'Daily Notification',
      channelDescription: 'Pushes a daily notification at 10:30 PM',
      importance: Importance.max,
      priority: Priority.high,
      icon: '@mipmap/ic_launcher',
      sound: RawResourceAndroidNotificationSound('notification_sound'),
      playSound: true,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    for (var weekdayEntity in weekdayEntities) {
      final id = notificationId + weekdayEntity;
      await cancelNotifications(id);
      final notificationTemplate =
          HabitNotificationTemplates.getRandomTemplate(habit.title);

      final tz.TZDateTime scheduledDate = _nextInstanceOfDay(
        day: weekdayEntity,
        timeH: notificationItem.timeH,
        timeM: notificationItem.timeM,
      );
      await _localNotifications.zonedSchedule(
        id,
        notificationTemplate.title,
        notificationTemplate.body,
        scheduledDate,
        platformChannelSpecifics,
        //  uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  Future<void> scheduleOneTimeNotification({
    required int id,
    required String title,
    required List<int> weekdays,
    required String body,
    required int timeH,
    required int timeM,
  }) async {
    // Cancel previously scheduled notifications
    await cancelNotifications(id);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'daily_notification',
      'Daily Notification',
      channelDescription: 'Pushes a daily notification at 10:30 PM',
      importance: Importance.max,
      priority: Priority.high,
    );
    const iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    for (var day in weekdays) {
      final tz.TZDateTime scheduledDate = _nextInstanceOfDay(
        day: day,
        timeH: timeH,
        timeM: timeM,
      );

      await _localNotifications.zonedSchedule(
        id,
        title,
        title,
        scheduledDate,
        platformChannelSpecifics,

        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        // uiLocalNotificationDateInterpretation:
        //     UILocalNotificationDateInterpretation.wallClockTime,

        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfDay({
    required int day,
    required int timeH,
    required int timeM,
  }) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      timeH,
      timeM,
    );

    while (scheduledDate.weekday != day || scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> cancelNotifications(int notificationId) async {
    await _localNotifications.cancel(notificationId);
  }

  Future<void> cancelAllForHabit(String habitId) async {
    final base = habitId.hashCode;
    for (var weekday = 1; weekday <= 7; weekday++) {
      await cancelNotifications(base + weekday);
    }
  }
}
