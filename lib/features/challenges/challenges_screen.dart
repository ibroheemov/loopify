import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';

class ChallengesScreen extends StatelessWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Center(
        child: Text(
          "Coming soon...",
          style: textTheme.displayLarge,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
