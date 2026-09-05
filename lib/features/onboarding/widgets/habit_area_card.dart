import 'package:betterloop/models/habit_area.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_svg.dart';
import 'package:flutter/material.dart';

class HabitAreaCard extends StatelessWidget {
  final List<Widget> children;
  final HabitArea area;
  final ExpansibleController? controller;
  final void Function(bool)? onExpansionChanged;

  const HabitAreaCard({
    super.key,
    required this.children,
    required this.area,
    required this.controller,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28))),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          maintainState: true,
          controller: controller,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(28))),
          minTileHeight: 80,
          title: Row(
            children: [
              AppSvg(
                path: "assets/images/onboarding/${area.emoji}.svg",
                width: 40,
              ),
              SizedBox(width: AppSpacing.horizontal),
              Text(area.name, style: textTheme.titleMedium)
            ],
          ),
          onExpansionChanged: onExpansionChanged,
          children: children,
        ),
      ),
    );
  }
}
