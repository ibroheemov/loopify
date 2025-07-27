import 'package:betterloop/constants/lifestyle_icons.dart';
import 'package:betterloop/constants/negative_icons.dart';
import 'package:betterloop/constants/popular.dart';
import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/models/hive_icon.dart';
import 'package:flutter/material.dart';

import '../../models/habit_type.dart';

class OnboardingHabit {
  final String id;

  final String areaId;

  final String title;

  final GoalType type;

  final IconData icon;

  OnboardingHabit({
    required this.id,
    required this.areaId,
    required this.title,
    required this.type,
    required this.icon,
  });
}

final hiveIcon = NegativeIcons.drink_can_soda;

final topGoodHabits = [
  OnboardingHabit(
    id: 'drink_water',
    title: 'Drink Water',
    type: GoalType.good,
    areaId: "onboarding",
    icon: PopularIcons.glass_of_water_with_drop,
  ),
  OnboardingHabit(
    id: 'wake_early',
    title: 'Wake Up Early',
    type: GoalType.good,
    areaId: "onboarding",
    icon: LifeStyleIcons.clock,
  ),
  OnboardingHabit(
    id: 'read',
    title: 'Read 10 Pages',
    type: GoalType.good,
    areaId: "onboarding",
    icon: LifeStyleIcons.book,
  ),
  // etc.
];

final topBadHabits = [
  OnboardingHabit(
    id: 'stop_smoking',
    title: 'Stop Smoking',
    type: GoalType.bad,
    icon: NegativeIcons.cigarette_stop,
    areaId: "onboarding",
  ),
  OnboardingHabit(
    id: 'limit_screen_time',
    title: 'Limit Screen Time',
    type: GoalType.bad,
    icon: NegativeIcons.mobile_screen_button_solid,
    areaId: "onboarding",
  ),
  OnboardingHabit(
    id: 'no_sugar',
    title: 'Avoid Sugar',
    type: GoalType.bad,
    icon: NegativeIcons.candy,
    areaId: "onboarding",
  ),
  // etc.
];
