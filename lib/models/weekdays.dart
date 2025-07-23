import 'package:hive/hive.dart';

part 'weekdays.g.dart';

@HiveType(typeId: 7)
class Weekdays {
  @HiveField(0)
  final bool isXdaysPerWeek;

  @HiveField(1)
  final int daysPerWeek;

  @HiveField(2)
  final List<int> selectedWeekDays;

  Weekdays({
    this.isXdaysPerWeek = false,
    this.daysPerWeek = 3,
    required this.selectedWeekDays,
  });

  factory Weekdays.defaultWeekdays() =>
      Weekdays(selectedWeekDays: [1, 2, 3, 4, 5, 6, 7]);

  factory Weekdays.toWeekdays(
          {required Weekdays weekdays,
          bool? isXdaysPerWeek,
          int? daysPerWeek,
          List<int>? selectedWeekDays}) =>
      Weekdays(
        isXdaysPerWeek: isXdaysPerWeek ?? weekdays.isXdaysPerWeek,
        daysPerWeek: daysPerWeek ?? weekdays.daysPerWeek,
        selectedWeekDays: selectedWeekDays ?? weekdays.selectedWeekDays,
      );
}
