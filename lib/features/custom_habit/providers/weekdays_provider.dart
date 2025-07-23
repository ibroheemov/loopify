import 'package:betterloop/models/weekdays.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weekdaysProvider =
    StateProvider<Weekdays>((ref) => Weekdays.defaultWeekdays());
