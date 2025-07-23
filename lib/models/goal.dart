import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'goal.g.dart';

@HiveType(typeId: 6)
class Goal {
  @HiveField(0)
  final bool enabled;

  @HiveField(1)
  final String unit;

  @HiveField(2)
  final int value;

  Goal({required this.enabled, required this.unit, required this.value});

  factory Goal.defaultGoal() => Goal(enabled: false, unit: "pages", value: 10);

  factory Goal.toGoal(
          {required Goal goal, bool? enabled, String? unit, int? value}) =>
      Goal(
        enabled: enabled ?? goal.enabled,
        unit: unit ?? goal.unit,
        value: value ?? goal.value,
      );
}
