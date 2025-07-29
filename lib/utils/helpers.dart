import 'dart:ui';

import 'package:betterloop/features/settings/widgets/choose_themes.dart';
import 'package:flutter/material.dart';

class Helpers {
  static Color parseColor(String colorString) {
    colorString = colorString.replaceAll('#', '');
    int colorValue = int.parse(colorString, radix: 16);
    return Color(colorValue).withOpacity(1);
  }

  String timeAgoSinceDate(DateTime dateTime, {bool numericDates = true}) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks ${weeks == 1 ? 'week' : 'weeks'} ago';
    } else if (difference.inDays < 365) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  static int getNumberOfDaysInMonth() {
    DateTime firstDayOfNextMonth =
        DateTime(DateTime.now().year, DateTime.now().month + 1, 1);
    // Subtracting one day from the first day of the next month gives the last day of the current month
    DateTime lastDayOfMonth = firstDayOfNextMonth.subtract(Duration(days: 1));
    // Return the day component of the last day of the month, which gives the number of days in the month
    return lastDayOfMonth.day;
  }
}
