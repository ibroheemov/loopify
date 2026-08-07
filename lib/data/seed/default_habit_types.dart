import 'package:betterloop/constants/lifestyle_icons.dart';
import 'package:betterloop/constants/negative_icons.dart';
import 'package:betterloop/constants/popular.dart';
import 'package:betterloop/models/goal.dart';
import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/models/habit.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:betterloop/models/reminder.dart';
import 'package:betterloop/models/weekdays.dart';
import 'package:flutter/material.dart';
import 'package:uuid/v1.dart';

class OnboardingHabit {
  final String id;

  final String areaId;

  final String title;

  final GoalType type;

  final Goal goal;

  final IconData icon;

  OnboardingHabit({
    required this.id,
    required this.areaId,
    required this.title,
    required this.type,
    required this.icon,
    required this.goal,
  });
}

final showcaseViewHabit = Habit(
  id: UuidV1().generate(),
  title: "Stretch",
  icon: HiveIcon(
    code: LifeStyleIcons.stretchingExercises.codePoint,
    family: LifeStyleIcons.stretchingExercises.fontFamily,
  ),
  color: "FE7450",
  createdAt: DateTime.now(),
  goal: Goal(enabled: true, unit: "Minutes", value: 20),
  weekdays: Weekdays.defaultWeekdays(),
  reminder: Reminder.defaultReminder(),
  showcaseview: true,
);

final topGoodHabits = [
  OnboardingHabit(
    id: 'drink_water',
    title: 'Drink 8 glasses of water/day',
    type: GoalType.good,
    areaId: "onboarding",
    icon: PopularIcons.glassOfWaterWithDrop,
    goal: Goal(enabled: true, unit: "Glasses", value: 8),
  ),
  OnboardingHabit(
    id: 'wake_early',
    title: 'Wake Up Early',
    type: GoalType.good,
    areaId: "onboarding",
    icon: LifeStyleIcons.clock,
    goal: Goal.defaultGoal(),
  ),
  OnboardingHabit(
    id: 'read',
    title: 'Read 10 Pages/day',
    type: GoalType.good,
    areaId: "onboarding",
    icon: LifeStyleIcons.book,
    goal: Goal(enabled: true, unit: "Pages", value: 10),
  ),
  // etc.
];

final topBadHabits = [
  OnboardingHabit(
    id: 'stop_smoking',
    title: 'Stop Smoking',
    type: GoalType.bad,
    icon: NegativeIcons.cigaretteStop,
    areaId: "onboarding",
    goal: Goal.defaultGoal(),
  ),
  OnboardingHabit(
    id: 'limit_screen_time',
    title: 'Limit Screen Time',
    type: GoalType.bad,
    icon: NegativeIcons.mobileScreenButtonSolid,
    areaId: "onboarding",
    goal: Goal.defaultGoal(),
  ),
  OnboardingHabit(
    id: 'no_sugar',
    title: 'Avoid Sugar',
    type: GoalType.bad,
    icon: NegativeIcons.candy,
    areaId: "onboarding",
    goal: Goal.defaultGoal(),
  ),
];
