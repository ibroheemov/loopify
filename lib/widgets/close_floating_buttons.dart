import 'package:betterloop/constants/general_icons.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';

class CloseFloatingButtons extends StatelessWidget {
  const CloseFloatingButtons(
      {super.key, required this.label, required this.onPressed});
  final String label;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.horizontal),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton.filled(
            style: IconButton.styleFrom(
                fixedSize: Size(52, 52),
                padding: EdgeInsets.all(5),
                backgroundColor: AppColors.of(context).backgroundDark),
            iconSize: 30,
            color: AppColors.of(context).textSecondary,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(GeneralIcons.close),
          ),
          SizedBox(width: AppSpacing.sm),
          PrimaryButton(
            isRounded: true,
            label: label,
            onPressed: onPressed,
          )
        ],
      ),
    );
  }
}
