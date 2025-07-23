// onboarding_step_10_finish.dart
import 'package:betterloop/routes/route_names.dart';
import 'package:flutter/material.dart';

class OnboardingStep7Finish extends StatelessWidget {
  const OnboardingStep7Finish({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: const Text('Start Using HabitFlow!'),
        onPressed: () {
          // Mark onboarding complete
          Navigator.pushReplacementNamed(context, RouteNames.navigation);
        },
      ),
    );
  }
}
