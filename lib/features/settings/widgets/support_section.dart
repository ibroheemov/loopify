import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/separator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'single_setting_container.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.md),
          child: Text(
            "Support".toUpperCase(),
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
                  Navigator.pushNamed(context, RouteNames.faqs);
                },
                icondata: Icons.contact_support_rounded,
                title: "FAQs",
              ),
              Separator(),
              SingleSettingContainer(
                onTap: contactSupport,
                icondata: Icons.alternate_email_sharp,
                title: "Contact Support",
              ),
              Separator(),
              SingleSettingContainer(
                onTap: reportBug,
                icondata: Icons.bug_report,
                title: "Report a Bug",
              ),
            ],
          ),
        ),
      ],
    );
  }

  void contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'apexhabit.help@gmail.com',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Handle the error
      print('Could not launch email client');
    }
  }

  void reportBug() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'apexhabit.help@gmail.com',
      query:
          'subject=Bug Report&body=Please describe the bug here...\n\n---\nDevice Info: [Your device info here]',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      // Handle the error
      print('Could not launch email client');
    }
  }
}
