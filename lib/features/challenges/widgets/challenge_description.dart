import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChallengeDescription extends StatelessWidget {
  const ChallengeDescription({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Column(
        children: [
          if (!challenge.forMuslims)
            Text(
              textAlign: TextAlign.center,
              style: textTheme.titleMedium,
              challenge.description,
            ),
          if (challenge.forMuslims)
            Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium,
                  challenge.hadith_en,
                ),
                SizedBox(height: AppSpacing.lg),
                Text(
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium
                      ?.copyWith(wordSpacing: 5, height: 2),
                  challenge.hadith_ar,
                ),
              ],
            )
        ],
      ),
    );
  }
}
