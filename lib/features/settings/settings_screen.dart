import 'package:betterloop/features/settings/widgets/reasons_to_upgrade.dart';
import 'package:betterloop/features/settings/widgets/single_setting_container.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/separator.dart';
import 'package:flutter/material.dart';

import 'widgets/app_info_section.dart';
import 'widgets/support_section.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // User? get user => FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Settings",
        ),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Align(
              //   alignment: Alignment.center,
              //   child: Column(
              //     children: [
              //       Container(
              //         clipBehavior: Clip.hardEdge,
              //         width: 100,
              //         height: 100,
              //         decoration: BoxDecoration(
              //           image: null,
              //           shape: BoxShape.circle,
              //           color: Theme.of(context).colorScheme.secondary,
              //         ),
              //         child: Stack(
              //           alignment: Alignment.center,
              //           clipBehavior: Clip.hardEdge,
              //           children: [
              //             Positioned(
              //               bottom: 0,
              //               child: Container(
              //                 child: Icon(GeneralIcons.user),
              //               ),
              //             )
              //           ],
              //         ),
              //       ),
              //       SizedBox(height: 10),
              //       Text(
              //         "Anonymous",
              //         style:
              //             TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //       ),
              //       SizedBox(height: 10),
              //     ],
              //   ),
              // ),
              ReasonsToUpgrade(),
              SizedBox(height: AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.only(left: AppSpacing.md),
                child: Text(
                  "General".toUpperCase(),
                  style: textTheme.titleMedium,
                ),
              ),
              SizedBox(height: AppSpacing.sm),
              AppCard(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      SingleSettingContainer(
                        icondata: Icons.backup,
                        title: "Backup",
                      ),
                      Separator(),
                      SingleSettingContainer(
                        icondata: Icons.restart_alt_outlined,
                        title: "Restore data",
                      ),
                      Separator(),
                      SingleSettingContainer(
                        icondata: Icons.dark_mode,
                        title: "Dark mode",
                      ),
                      // SettingsTheme(),
                    ],
                  )),
              SizedBox(height: AppSpacing.lg),
              AppInfoSection(),
              SizedBox(height: AppSpacing.lg),
              SupportSection(),
              SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
