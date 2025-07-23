import 'package:betterloop/theme/colors.dart';
import 'package:flutter/material.dart';

class IconBox extends StatelessWidget {
  final void Function() onTap;
  final IconData icon;
  final bool isSelected;

  const IconBox({
    super.key,
    required this.onTap,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary.withOpacity(0.3)
              : colorScheme.surface,
          border: Border.all(width: 0.5, color: colorScheme.outline),
          borderRadius: BorderRadius.circular(14.0),
        ),
        child: Center(
          child: Icon(icon,
              color: isSelected
                  ? colorScheme.primary
                  : AppColors.of(context).textSecondary,
              size: 40),
        ),
      ),
    );
  }
}
