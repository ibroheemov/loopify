import 'package:betterloop/features/onboarding/providers/goal_type_provider.dart';
import 'package:betterloop/models/goal_type.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:betterloop/widgets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingStep1GoalFocus extends ConsumerStatefulWidget {
  const OnboardingStep1GoalFocus({super.key, required this.goToNextPage});
  final void Function() goToNextPage;

  @override
  ConsumerState<OnboardingStep1GoalFocus> createState() =>
      _OnboardingStep1GoalFocusState();
}

class _OnboardingStep1GoalFocusState
    extends ConsumerState<OnboardingStep1GoalFocus> {
  GoalType? selectedGoal;

  Future<void> _handleSelection(GoalType type) async {
    setState(() {
      selectedGoal = type;
    });

    // Save to SharedPreferences (assuming SharedPrefsService is already implemented)
    // await SharedPrefsService.setGoalType(type.name);

    // Move to next step
    widget.goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final goalOptions = [
      _GoalOption(
        label: 'Build Good Habits',
        icon: 'assets/images/icons/like.svg',
        color: colorScheme.primary,
        type: GoalType.good,
      ),
      _GoalOption(
        label: 'Break Bad Habits',
        icon: 'assets/images/icons/dislike.svg',
        color: AppColors.error,
        type: GoalType.bad,
      ),
      _GoalOption(
        label: 'Both',
        icon: 'assets/images/icons/bolt.svg',
        color: AppColors.accent,
        type: GoalType.both,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(height: AppSpacing.lg),
          Text(
            'What’s your main \nfocus?',
            style: textTheme.displayLarge,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppSpacing.xxl),
          ..._buildButtons(goalOptions)
        ],
      ),
    );
  }

  List<Widget> _buildButtons(List<_GoalOption> goalOptions) {
    return goalOptions
        .map(
          (option) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.vertical),
            child: GoalFocusButton(
              label: option.label,
              icon: option.icon,
              onPressed: () {
                ref.read(goalTypeProvider.notifier).state = option.type;
                widget.goToNextPage();
              },
              color: option.color,
            ),
          ),
        )
        .toList();
  }
}

class GoalFocusButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final String icon;
  final Color color;

  const GoalFocusButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      width: double.infinity,
      height: 80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: color.withAlpha(50)),
                  child: Center(
                    child: AppSvg(
                      path: icon,
                      width: 30,
                      height: 30,
                      color: color,
                    ),
                  ),
                ),
                SizedBox(width: AppSpacing.horizontal),
                Text(label, style: textTheme.titleMedium)
              ],
            ),
            AppSvg(
              path: "assets/images/icons/alt-arrow-right.svg",
              width: 30,
              height: 30,
              color: colorScheme.onBackground,
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalOption {
  final String label;
  final String icon;
  final Color color;
  final GoalType type;

  const _GoalOption({
    required this.label,
    required this.icon,
    required this.color,
    required this.type,
  });
}
