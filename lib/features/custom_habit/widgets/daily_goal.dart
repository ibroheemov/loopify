import 'package:betterloop/features/custom_habit/providers/goal_provider.dart';
import 'package:betterloop/models/goal.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/utils/extensions.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/custom_cupertino_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const List<String> _fruitNames = <String>[
  'Glasses',
  'Cups',
  'Pages',
  'Hours',
  'Minutes',
  'Times',
];

class SectionDailyGoal extends ConsumerStatefulWidget {
  const SectionDailyGoal({super.key});

  @override
  ConsumerState<SectionDailyGoal> createState() => _SectionDailyGoalState();
}

class _SectionDailyGoalState extends ConsumerState<SectionDailyGoal> {
  final expansionController = ExpansionTileController();
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final goal = ref.watch(goalProvider);
    return AppCard(
      padding: EdgeInsets.all(0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: AppSpacing.md_lg),
          childrenPadding: EdgeInsets.symmetric(horizontal: AppSpacing.sm)
              .copyWith(bottom: AppSpacing.md_lg),
          trailing: Icon(
            Icons.arrow_forward_ios_outlined,
            size: 20,
            color: AppColors.of(context).surfaceSecondary,
          ),
          controller: expansionController,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28))),
          minTileHeight: 80,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Daily goal".toUpperCase(), style: textTheme.titleMedium),
              Text(
                enabled ? "ON" : "OFF",
                style: textTheme.titleMedium?.copyWith(
                    color: enabled
                        ? colorScheme.primary
                        : AppColors.of(context).surfaceSecondary),
              ),
            ],
          ),
          onExpansionChanged: (value) {
            setState(() {
              enabled = value;
            });
            ref.read(goalProvider.notifier).state =
                Goal.toGoal(goal: goal, enabled: value);
          },
          children: [
            SizedBox(
              height: 150,
              child: Row(
                children: [
                  Expanded(
                    child: CustomCupertinoPicker(
                      items: List.generate(200, (val) => (val + 1).addZero()),
                      onSelectedItemChanged: onGoalValueChanged,
                    ),
                  ),
                  Expanded(
                    child: CustomCupertinoPicker(
                      items: _fruitNames,
                      onSelectedItemChanged: onGoalUnitChanged,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void onGoalValueChanged(int value) {
    final goal = ref.read(goalProvider);

    ref.read(goalProvider.notifier).state =
        Goal.toGoal(goal: goal, value: value);
  }

  void onGoalUnitChanged(int value) {
    final goal = ref.read(goalProvider);

    ref.read(goalProvider.notifier).state =
        Goal.toGoal(goal: goal, unit: _fruitNames[value]);
  }
}
