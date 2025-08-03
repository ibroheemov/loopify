import 'package:betterloop/routes/route_names.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_svg.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(32),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppSvg(
              path: 'assets/images/onboarding/welcome.svg',
              width: 300,
              height: 300,
            ),
            // Icon(Icons.favorite,
            //     size: 80, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Welcome to Loopify!',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Build better habits. Break bad ones. Become your best self.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.lg),
            PrimaryButton(
              isRounded: true,
              label: "Let's get started",
              onPressed: () {
                Navigator.pushNamed(context, RouteNames.onboarding);
              },
            )
          ],
        ),
      ),
    );
  }
}
