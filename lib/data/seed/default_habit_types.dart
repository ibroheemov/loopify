import 'package:betterloop/constants/negative_icons.dart';
import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/models/hive_icon.dart';

import '../../models/habit_type.dart';

final defaultHabitTypes = [
  // HabitType(
  //   id: 'water',
  //   areaId: 'health',
  //   title: 'Drink Water',
  //   type: HabitNature.build,
  //   goal: 'Drink 8 glasses per day',
  //   icon: hiveIcon,
  // ),

  // HabitType(
  //   id: 'nutrition',
  //   areaId: 'mindfulness',
  //   title: 'Limit Social Media',
  //   type: HabitNature.stop,
  //   goal: 'Less than 1 hour/day',
  //   icon: hiveIcon,
  // ),

  // HabitType(
  //   id: 'read_book',
  //   areaId: 'learning',
  //   title: 'Read book',
  //   type: HabitNature.build,
  //   goal: '10 pages hour/day',
  //   icon: hiveIcon,
  // ),
  // Add more
];

final hiveIcon = HiveIcon(
  code: NegativeIcons.drink_can_soda.codePoint,
  family: NegativeIcons.drink_can_soda.fontFamily,
);

final topGoodHabits = [
  HabitType(
    id: 'drink_water',
    title: '💧 Drink Water',
    type: GoalType.good,
    areaId: "onboarding",
    icon: hiveIcon,
  ),
  HabitType(
    id: 'wake_early',
    title: '⏰ Wake Up Early',
    type: GoalType.good,
    areaId: "onboarding",
    icon: hiveIcon,
  ),
  HabitType(
    id: 'read',
    title: '📚 Read 10 Pages',
    type: GoalType.good,
    areaId: "onboarding",
    icon: hiveIcon,
  ),
  // etc.
];

final topBadHabits = [
  HabitType(
    id: 'stop_smoking',
    title: '🚭 Stop Smoking',
    type: GoalType.bad,
    icon: hiveIcon,
    areaId: "onboarding",
  ),
  HabitType(
    id: 'limit_screen_time',
    title: '📵 Limit Screen Time',
    type: GoalType.bad,
    icon: hiveIcon,
    areaId: "onboarding",
  ),
  HabitType(
    id: 'no_sugar',
    title: '🍬 Avoid Sugar',
    type: GoalType.bad,
    icon: hiveIcon,
    areaId: "onboarding",
  ),
  // etc.
];
