import 'package:flutter/services.dart';

class NotificationSetup {
  static const platform = MethodChannel('com.app.apexhabit/notifications');

  static Future<void> createNotificationChannel() async {
    try {
      await platform.invokeMethod('createNotificationChannel');
    } on PlatformException catch (e) {
      print("Failed to create notification channel: '${e.message}'.");
    }
  }
}
