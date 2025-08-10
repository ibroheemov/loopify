import 'package:betterloop/features/challenges/widgets/challenge_card.dart';
import 'package:betterloop/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/challenge_di.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final challengesAsync = ref.watch(challengesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Challenges')),
      body: challengesAsync.when(
        data: (challenges) => AppContainer(
          child: ListView.builder(
            itemCount: challenges.length,
            itemBuilder: (_, i) => ChallengeCard(challenge: challenges[i]),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
      ),
    );
  }
}

// Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                       decoration: BoxDecoration(
//                           color: AppColors.of(context).onSurfaceBg,
//                           borderRadius: BorderRadius.circular(100)),
//                       child: Text("100 / day",
//                           style: textTheme.titleMedium
//                               ?.copyWith(color: AppColors.accent)),
//                     ),
