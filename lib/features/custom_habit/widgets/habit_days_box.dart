import 'package:flutter/material.dart';

class HabitDaysBox extends StatelessWidget {
  const HabitDaysBox({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.content,
  });

  final String content;
  final bool isSelected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      // shadow: false,
      // padding: EdgeInsets.all(AppSpacing.sm),
      // borderRadius: AppSpacing.sm,
      // bgColor:
      //     isSelected ? theme.repeatAtActiveBgColor : theme.colorScheme.tertiary,
      onTap: onTap,
      child: Container(
        // width: 65,
        // height: 65,
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelected
                  ? colorScheme.primary.withOpacity(0.2)
                  : colorScheme.outline),
          shape: BoxShape.circle,
          color: isSelected
              ? colorScheme.primary.withOpacity(0.2)
              : colorScheme.outline,
        ),
        child: Center(
          child: Text(
            content.toUpperCase(),
            style: textTheme.titleMedium?.copyWith(
                color: isSelected ? colorScheme.primary : colorScheme.surface),
          ),
        ),
      ),
    );
  }
}
