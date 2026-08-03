import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'single_setting_container.dart';

class AppInfoSection extends StatelessWidget {
  const AppInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Text(
            "App Information".toUpperCase(),
            style: textTheme.titleMedium,
          ),
        ),
        SizedBox(height: AppSpacing.sm),
        AppCard(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              SingleSettingContainer(
                onTap: () {
                  Navigator.pushNamed(context, RouteNames.policy);
                },
                icondata: Icons.privacy_tip,
                title: "Privacy policy",
              ),
              Separator(),
              SingleSettingContainer(
                icondata: Icons.numbers,
                title: "App version",
                rightContent: Text(
                  "1.0.0",
                  style: textTheme.titleMedium
                      ?.copyWith(color: AppColors.of(context).surfaceSecondary),
                ),
              ),
              Separator(),
              SingleSettingContainer(
                onTap: () {
                  Share.share(
                    'Check out Loopify, the ultimate habit tracker app! Download now: https://play.google.com/store/apps/details?id=com.loopify.app', // Replace with your actual app link
                    subject: 'Join Loopify Today!',
                  );
                },
                icondata: Icons.share,
                title: "Share app",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
