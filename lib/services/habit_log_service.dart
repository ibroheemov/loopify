import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class HabitLogService {
  static const String _boxName = 'habit_logs';

  static Future<Box<HabitLog>> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<HabitLog>(_boxName);
    }
    return Hive.box<HabitLog>(_boxName);
  }

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

  static Future<int> getProgressForHabit(String habitId,
      [DateTime? day]) async {
    final box = await openBox();
    final logs = box.values.where((log) {
      return log.habitId == habitId &&
          isSameDay(log.completedAt,
              day ?? DateTime.now()); // you'll need a helper for this
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

  static Future<bool> isHabitCompleted(String habitId, DateTime date) async {
    final box = await openBox();
    final result = box.values.firstWhereOrNull((log) =>
        log.habitId == habitId &&
        log.completedAt.year == date.year &&
        log.completedAt.month == date.month &&
        log.completedAt.day == date.day);

    return result != null;
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
      print(logToRemove.habitId);
      await logToRemove.delete();
    }
  }

  static Future<double> getAverageDailyProgress(
      Habit habit, DateTime month) async {
    final totalDays = DateUtils.getDaysInMonth(month.year, month.month);
    int totalProgress = 0;

    if (habit.goal.enabled) {
      for (int day = 1; day <= totalDays; day++) {
        final date = DateTime(month.year, month.month, day);
        final progress =
            await HabitLogService.getProgressForHabit(habit.id, date);
        totalProgress += progress;
      }
      return totalProgress / totalDays;
    } else {
      final logs = await getLogsForHabitInMonth(habit.id, month);

      return logs.length / totalDays;
    }
  }

  static Future<int> getPerfectDaysForMonth(Habit habit, DateTime month) async {
    final year = month.year;
    final monthNumber = month.month;
    final daysInMonth = DateUtils.getDaysInMonth(year, monthNumber);

    int perfectDays = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, monthNumber, day);
      bool isPerfect = false;

      if (habit.goal.enabled) {
        final progress =
            await HabitLogService.getProgressForHabit(habit.id, date);

        isPerfect = progress == habit.goal.value;
      } else {
        isPerfect = await HabitLogService.isHabitCompleted(habit.id, date);
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
    int completedDays = 0;

    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(year, monthNumber, day);
      bool isCompleted = false;

      if (habit.goal.enabled) {
        final progress =
            await HabitLogService.getProgressForHabit(habit.id, date);

        isCompleted = progress == habit.goal.value;
      } else {
        isCompleted = await HabitLogService.isHabitCompleted(habit.id, date);
      }

      if (isCompleted) completedDays++;
    }

    final completionRate = (completedDays / daysInMonth) * 100;
    return completionRate;
  }

  static Future<int> getCurrentMonthStreak(Habit habit) async {
    final now = DateTime.now();
    int streak = 0;

    for (int i = 0; i < now.day; i++) {
      final date = DateTime(now.year, now.month, now.day - i);

      bool isCompleted = false;

      if (habit.goal.enabled) {
        final progress =
            await HabitLogService.getProgressForHabit(habit.id, date);

        isCompleted = progress == habit.goal.value;
      } else {
        isCompleted = await HabitLogService.isHabitCompleted(habit.id, date);
      }

      if (isCompleted) {
        streak++;
      } else {
        break; // streak ends
      }
    }

    return streak;
  }
}
