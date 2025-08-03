import 'dart:ffi';

import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/constants/premium_icons.dart';
import 'package:betterloop/providers/pro_user_provider.dart';
import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconBox extends StatelessWidget {
  final void Function(bool, bool) onTap;
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
    final isPremium = premiumicons.contains(icon);

    return Consumer(builder: (context, ref, _) {
      final isProAsync = ref.watch(isProUserProvider);
      final isPro = isProAsync.hasValue && isProAsync.value!;
      // final isPro = true;

      return GestureDetector(
        onTap: () => onTap(isPremium, isPro),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.primary.withOpacity(0.3)
                : colorScheme.surface,
            border: Border.all(
                width: 0.5,
                color: isPremium && !isPro
                    ? AppColors.accent
                    : colorScheme.outline),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Stack(
            children: [
              if (isPremium && !isPro)
                Positioned(
                    top: 5,
                    right: 5,
                    child: Icon(
                      GeneralIcons.star,
                      color: AppColors.accent,
                      size: 15,
                    )),
              Center(
                child: Icon(icon,
                    color: isSelected
                        ? colorScheme.primary
                        : AppColors.of(context).textSecondary,
                    size: 40),
              )
            ],
          ),
        ),
      );
    });
  }
}
