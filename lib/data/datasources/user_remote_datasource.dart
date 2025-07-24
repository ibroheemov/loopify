import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/habit_log.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:betterloop/services/habit_log_service.dart';
import 'package:betterloop/services/habit_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRemoteDatasource {
  Future<void> backup();
  Future<void> restore();
  Future<Timestamp?> lastBackupTime();
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  User? get user => FirebaseAuth.instance.currentUser;

  @override
  Future<void> backup() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("User not signed in");

      final firestore = FirebaseFirestore.instance;
      final habitsBox = await HabitService.getAllHabits();
      final logsBox = await HabitLogService.getAllHabitLogs();

      final userRef = firestore.collection('users').doc(user.uid);

      // Backup habits
      // final habits = habitsBox.values.toList();
      final habitBatch = firestore.batch();
      for (final habit in habitsBox) {
        habitBatch.set(
          userRef.collection('habits').doc(habit.id),
          {
            'id': habit.id,
            'title': habit.title,
            'icon': habit.icon.toJson(),
            'color': habit.color,
            'createdAt': habit.createdAt.toIso8601String(),
            'goal': habit.goal.toJson(),
            'weekdays': habit.weekdays.toJson(),
          },
        );
      }

      // Backup logs
      final logBatch = firestore.batch();
      for (final log in logsBox) {
        final logId = '${log.habitId}_${log.completedAt.toIso8601String()}';
        logBatch.set(
          userRef.collection('habit_logs').doc(logId),
          {
            'habitId': log.habitId,
            'completedAt': log.completedAt.toIso8601String(),
            'progress': log.progress,
          },
        );
      }

      // Last back time
      await userRef.collection('backup').doc('metadata').set({
        'lastBackupTime': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      await habitBatch.commit();
      await logBatch.commit();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> restore() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not signed in");

    final firestore = FirebaseFirestore.instance;
    final habitsBox = await HabitService.openBox();
    final logsBox = await HabitLogService.openBox();

    final userRef = firestore.collection('users').doc(user.uid);

    // Clear existing local data (optional)
    habitsBox.clear();
    logsBox.clear();

    // Restore habits
    final habitSnap = await userRef.collection('habits').get();
    for (var doc in habitSnap.docs) {
      final data = doc.data();
      habitsBox.put(
        data['id'],
        Habit(
          id: data['id'],
          title: data['title'],
          icon: HiveIcon.fromJson(data['icon']),
          color: data['color'],
          createdAt: DateTime.parse(data['createdAt']),
          goal: Goal.fromJson(data['goal']),
          weekdays: Weekdays.fromJson(data['weekdays']),
        ),
      );
    }

    // Restore logs
    final logSnap = await userRef.collection('habit_logs').get();
    for (var doc in logSnap.docs) {
      final data = doc.data();
      logsBox.add(HabitLog(
        habitId: data['habitId'],
        completedAt: DateTime.parse(data['completedAt']),
        progress: data['progress'],
      ));
    }
  }

  @override
  Future<Timestamp?> lastBackupTime() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception("User not signed in");

    try {
      final firestore = FirebaseFirestore.instance;
      final snapshot = await firestore
          .collection('users')
          .doc(user.uid)
          .collection('backup')
          .doc('metadata')
          .get();

      final lastBackupTime = snapshot.data()?['lastBackupTime'] as Timestamp?;
      return lastBackupTime;
    } catch (e) {
      rethrow;
    }
  }
}
