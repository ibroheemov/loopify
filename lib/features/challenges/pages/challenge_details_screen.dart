import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_card.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  const ChallengeDetailsScreen({super.key, required this.challenge});
  final Challenge challenge;

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final challenge = widget.challenge;

    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PrimaryButton(
        label: "Join Challenge",
        onPressed: () {},
        isRounded: true,
      ),
      body: SafeArea(
        child: AppContainer(
          child: Column(
            children: [
              SizedBox(height: AppSpacing.lg),
              AppCard(
                margin: EdgeInsets.symmetric(horizontal: AppSpacing.md),
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Title & subtitle
                    Text(
                      challenge.title,
                      style: textTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: AppSpacing.lg),
                    // Stats row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem("Goal", challenge.goal.value.toString(),
                            Icons.help_outline),
                        Container(
                          height: 50,
                          width: 2,
                          decoration: BoxDecoration(
                            color: AppColors.of(context).surfaceSecondary,
                          ),
                        ),
                        _buildStatItem("Duration", "${challenge.duration} days",
                            Icons.medication),
                        Container(
                          height: 50,
                          width: 2,
                          decoration: BoxDecoration(
                            color: AppColors.of(context).surfaceSecondary,
                          ),
                        ),
                        _buildStatItem("People", "100", Icons.scale),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.lg),
              if (!challenge.forMuslims)
                Text(
                  textAlign: TextAlign.center,
                  style: textTheme.titleLarge,
                  challenge.hadith_en,
                ),
              if (challenge.forMuslims)
                Column(
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge,
                      challenge.hadith_en,
                    ),
                    SizedBox(height: AppSpacing.lg),
                    Text(
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge
                          ?.copyWith(wordSpacing: 5, height: 2),
                      challenge.hadith_ar,
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.accent),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
              color: AppColors.of(context).textSecondary, fontSize: 14),
        ),
      ],
    );
  }
}
