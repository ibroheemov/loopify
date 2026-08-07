import 'package:flutter/services.dart';

class NotificationSetup {
  static const platform = MethodChannel('com.loopify.app/notifications');

  static Future<void> createNotificationChannel() async {
    try {
      await platform.invokeMethod('createNotificationChannel');
    } on PlatformException catch (_) {}
  }
}
