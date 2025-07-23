import 'package:betterloop/features/onboarding/pages/onboarding_step_1_goal_focus.dart';
import 'package:flutter/material.dart';

import 'pages/onboarding_step_2_goal_areas.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    OnboardingStep2GoalAreas(),
    OnboardingStep2GoalAreas(),
  ];

  void _goToNextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Finished onboarding
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Optionally show a dialog or ignore
    }
  }

  void _skipCurrentStep() {
    _goToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_currentPage + 1) / _pages.length;

    return Scaffold(
      appBar: AppBar(
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.chevron_left_rounded, size: 40),
                onPressed: _goToPreviousPage,
              )
            : null,
        actions: [
          if (_currentPage < _pages.length - 1)
            TextButton(
              onPressed: _skipCurrentStep,
              child: const Text('Skip'),
            ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(value: progress),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              children: [
                OnboardingStep1GoalFocus(
                  goToNextPage: _goToNextPage,
                ),
                OnboardingStep2GoalAreas(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
