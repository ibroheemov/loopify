import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:flutter/material.dart';

class PremiumFeatures extends StatelessWidget {
  const PremiumFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PremiumFeature(text: "Create Unlimited Habits"),
        PremiumFeature(text: "Unlock All Icons"),
        PremiumFeature(text: "Use Premium Color Sets"),
        PremiumFeature(text: "Backup & Restore Data"),
        PremiumFeature(text: "Detailed ananylysis of you progress"),
      ],
    );
  }
}

class PremiumFeature extends StatelessWidget {
  const PremiumFeature({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            GeneralIcons.check_circle_bold,
            color: AppColors.primary,
          ),
          SizedBox(width: 5),
          Text(text, style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
