import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HabitLogService {
  static const String _boxName = 'habit_logs';

  static Future<Box<HabitLog>> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<HabitLog>(_boxName);
    }
    return Hive.box<HabitLog>(_boxName);
  }

  /// Get box
  static Box<HabitLog> get _box => Hive.box<HabitLog>(_boxName);

  static ValueListenable<Box<HabitLog>> get boxListenable => _box.listenable();

  static Future<void> deleteLogsForHabit(String habitId) async {
    final box = await openBox();
    final keysToDelete = box.keys.where((key) {
      final log = box.get(key);
      return log?.habitId == habitId;
    }).toList();

    await box.deleteAll(keysToDelete);
  }

  static Future<List<HabitLog>> getAllHabitLogs() async {
    final box = await openBox();
    return box.values.toList();
  }

  /// Add a new log for a habit
  static Future<void> logCompletion(Habit habit, int progress,
      [DateTime? date]) async {
    final box = await openBox();

    final log = HabitLog(
      habitId: habit.id,
      completedAt: date ?? DateTime.now(),
      progress: progress,
    );

    await box.add(log);
  }

  static int getProgressForHabit(String habitId, [DateTime? day]) {
    final box = _box;
    final logs = box.values.where((log) {
      return log.habitId == habitId &&
          isSameDay(log.completedAt, day ?? DateTime.now());
    });

    return logs.fold<int>(0, (sum, log) => sum + log.progress);
  }

  static Future<void> undoAllProgressForHabitOnDay(String habitId,
      [DateTime? day]) async {
    final box = await openBox(); // Box<HabitLog>

    final keysToDelete = box.keys.where((key) {
      final log = box.get(key);
      if (log is! HabitLog) return false;

      return log.habitId == habitId &&
          isSameDay(log.completedAt, day ?? DateTime.now());
    }).toList();

    await box.deleteAll(keysToDelete);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Get all logs for a specific habit
  static Future<List<HabitLog>> getLogsForHabit(String habitId) async {
    final box = await openBox();
    return box.values.where((log) => log.habitId == habitId).toList();
  }

  /// Get logs completed today for a habit
  static Future<List<HabitLog>> getLogsForHabitToday(String habitId) async {
    final box = await openBox();
    final now = DateTime.now();
    return box.values
        .where((log) =>
            log.habitId == habitId &&
            log.completedAt.year == now.year &&
            log.completedAt.month == now.month &&
            log.completedAt.day == now.day)
        .toList();
  }

  static bool isHabitCompleted(String habitId, DateTime date) {
    final box = _box;
    final isCompleted = box.values.any((d) =>
        d.completedAt.year == date.year &&
        d.completedAt.month == date.month &&
        d.completedAt.day == date.day);

    return isCompleted;
  }

  /// Optional: remove a log (e.g. undo)
  static Future<void> removeLog(HabitLog log) async {
    await log.delete();
  }

  /// Get logs for a habit in the same month as [referenceDate]
  static Future<List<DateTime>> getLogsForHabitInMonth(
      String habitId, DateTime referenceDate) async {
    final allLogs = await getLogsForHabit(habitId);
    final thismonthLogs = allLogs
        .where((d) =>
            d.completedAt.year == referenceDate.year &&
            d.completedAt.month == referenceDate.month)
        .toList();
    return thismonthLogs.map((e) => e.completedAt).toList();
  }

  static Future<void> removeLogForToday(String habitId) async {
    // print(habitId);

    final box = await openBox();
    final today = DateTime.now();

    final logToRemove = box.values.firstWhereOrNull(
      (log) =>
          log.habitId == habitId &&
          log.completedAt.year == today.year &&
          log.completedAt.month == today.month &&
          log.completedAt.day == today.day,
    );
    if (logToRemove != null) {
      await logToRemove.delete();
    }
  }

  static Future<double> getAverageDailyProgress(
      Habit habit, DateTime month) async {
    final year = month.year;
    final monthNumber = month.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, monthNumber);
    final weekdays = habit.weekdays;

    int totalProgress = 0;
    int countedDays = 0;

    if (habit.goal.enabled) {
      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(year, monthNumber, day);
        final weekday = date.weekday;

        // Count only valid days
        final isExpectedDay = weekdays.isXdaysPerWeek ||
            weekdays.selectedWeekDays.contains(weekday);
        if (!isExpectedDay) continue;

        final progress = HabitLogService.getProgressForHabit(habit.id, date);
        totalProgress += progress;
        countedDays++;
      }
      return countedDays == 0 ? 0 : totalProgress / countedDays;
    } else {
      final logs = await getLogsForHabitInMonth(habit.id, month);

      // Count only valid days
      int expectedDays = 0;
      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(year, monthNumber, day);
        final weekday = date.weekday;

        final isExpectedDay = weekdays.isXdaysPerWeek ||
            weekdays.selectedWeekDays.contains(weekday);
        if (isExpectedDay) expectedDays++;
      }

      return expectedDays == 0 ? 0 : logs.length / expectedDays;
    }
  }

  static Future<int> getPerfectDaysForMonth(Habit habit, DateTime month) async {
    final year = month.year;
    final monthNumber = month.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, monthNumber);
    final weekdays = habit.weekdays;

    int perfectDays = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, monthNumber, day);
      final weekday = date.weekday; // 1 = Monday, ..., 7 = Sunday

      final isExpectedDay = weekdays.isXdaysPerWeek
          ? true // All days are potential candidates
          : weekdays.selectedWeekDays.contains(weekday);

      if (!isExpectedDay) continue;

      bool isPerfect = false;

      if (habit.goal.enabled) {
        final progress = HabitLogService.getProgressForHabit(habit.id, date);
        isPerfect = progress == habit.goal.value;
      } else {
        isPerfect = HabitLogService.isHabitCompleted(habit.id, date);
      }

      if (isPerfect) perfectDays++;
    }

    return perfectDays;
  }

  static Future<double> getMonthlyCompletionRate(
      Habit habit, DateTime month) async {
    final year = month.year;
    final monthNumber = month.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, monthNumber);
    final weekdays = habit.weekdays;

    int completedDays = 0;
    int expectedCompletions = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, monthNumber, day);
      final weekday = date.weekday; // 1 = Monday, ..., 7 = Sunday

      // Should this day be counted toward the goal?
      final bool isExpectedDay = weekdays.isXdaysPerWeek
          ? true // all days are valid; we'll count weeks later
          : weekdays.selectedWeekDays.contains(weekday);

      if (!isExpectedDay) continue;

      // Increment expected only for applicable days
      expectedCompletions++;

      bool isCompleted = false;
      if (habit.goal.enabled) {
        final progress = HabitLogService.getProgressForHabit(habit.id, date);
        isCompleted = progress == habit.goal.value;
      } else {
        isCompleted = HabitLogService.isHabitCompleted(habit.id, date);
      }

      if (isCompleted) completedDays++;
    }

    // Special handling if X times per week mode is enabled
    if (weekdays.isXdaysPerWeek) {
      // Count how many weeks are in this month
      final firstDay = DateTime(year, monthNumber, 1);
      final lastDay = DateTime(year, monthNumber, daysInMonth);

      // Calculate number of full or partial weeks in the month
      int totalWeeks =
          ((lastDay.difference(firstDay).inDays + firstDay.weekday) / 7).ceil();
      expectedCompletions = totalWeeks * weekdays.daysPerWeek;
    }

    if (expectedCompletions == 0) return 0;

    final completionRate = (completedDays / expectedCompletions) * 100;
    return completionRate;
  }

  static Future<int> getCurrentStreak(Habit habit) async {
    if (habit.weekdays.isXdaysPerWeek) {
      throw Exception("Use weekly streak logic for flexible weekly goals");
    }

    final today = DateTime.now();
    final createdAt = habit.createdAt;
    final startDate = DateTime(createdAt.year, createdAt.month, createdAt.day);

    int streak = 0;
    DateTime date = DateTime(today.year, today.month, today.day);

    // Walk backwards day-by-day from today until the habit's creation date,
    // so the streak doesn't artificially reset at the start of a calendar month.
    while (!date.isBefore(startDate)) {
      final isScheduledDay =
          habit.weekdays.selectedWeekDays.contains(date.weekday);

      if (isScheduledDay) {
        bool isCompleted;
        if (habit.goal.enabled) {
          final progress = HabitLogService.getProgressForHabit(habit.id, date);
          isCompleted = progress == habit.goal.value;
        } else {
          isCompleted = HabitLogService.isHabitCompleted(habit.id, date);
        }

        if (isCompleted) {
          streak++;
        } else {
          break; // streak broken on a scheduled day
        }
      }

      date = date.subtract(const Duration(days: 1));
    }

    return streak;
  }
}
