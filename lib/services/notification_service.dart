import 'dart:io';

import 'package:betterloop/config/notification_setup.dart';
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
    required NotificationItem notificationItem,
    required List<int> weekdayEntities,
  }) async {
    // Cancel previously scheduled notifications
    await cancelNotifications(notificationId);

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
      final tz.TZDateTime scheduledDate = _nextInstanceOfDay(
        day: weekdayEntity,
        timeH: notificationItem.timeH,
        timeM: notificationItem.timeM,
      );

      await _localNotifications.zonedSchedule(
        notificationId * 1000 + weekdayEntity,
        "${_notificationTitle(notificationId)} reminder",
        "weekdayEntity.body",
        scheduledDate,
        platformChannelSpecifics,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    }
  }

  String _notificationTitle(int id) {
    switch (id) {
      case 1:
        return "Global";
      case 2:
        return "Morning";
      case 3:
        return "Afternoon";
      default:
        return "Evening";
    }
  }

  String _notificationBody(int id) {
    switch (id) {
      case 1:
        return "Keep up the momentum! Remember to check in on your habits today";
      case 2:
        return "Good morning! Start your day strong by working on your habits";
      case 3:
        return "You're halfway through the day. Have you completed your habits yet?";
      default:
        return "The day is wrapping up. Don't forget to complete your habits before it ends!";
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
    print('id: $id');
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
}
