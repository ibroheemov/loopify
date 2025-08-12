import 'package:betterloop/domain/usecases/usecase.dart';
import 'package:betterloop/features/challenges/providers/isuser_joined_provider.dart';
import 'package:betterloop/features/challenges/providers/join_challenge_notifier.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/widgets/buttons/app_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinButton extends ConsumerWidget {
  const JoinButton({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context, ref) {
    final isJoined = ref.watch(isUserJoinedProvider);
    final joinState = ref.watch(challengeNotifierProvider);

    return isJoined
        ? Container()
        : PrimaryButton(
            isLoading: joinState.isLoading,
            label: "Join Challenge",
            onPressed: () {
              ref.read(challengeNotifierProvider.notifier).joinChallenge(
                    JoinChallengeParams(
                      challengeId: challenge.id,
                      displayName: "Guest ${challenge.participants}",
                    ),
                  );
            },
            isRounded: true,
          );
  }
}
