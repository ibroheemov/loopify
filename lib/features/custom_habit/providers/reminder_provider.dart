import 'package:betterloop/models/reminder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final reminderProvider =
    StateProvider<Reminder>((ref) => Reminder.defaultReminder());
