import 'package:betterloop/features/challenges/providers/isuser_joined_provider.dart';
import 'package:betterloop/features/challenges/providers/join_challenge_notifier.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/widgets/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaveButton extends ConsumerStatefulWidget {
  const LeaveButton({super.key, required this.challenge});
  final Challenge challenge;

  @override
  ConsumerState<LeaveButton> createState() => _LeaveButtonState();

  static const dialogTitle = 'Are you sure you want to leave the challenge?';

  static const dialogContent =
      'When you leave the challenge, your progress will be lost';
}

class _LeaveButtonState extends ConsumerState<LeaveButton> {
  @override
  Widget build(BuildContext context) {
    final isJoined = ref.watch(isUserJoinedProvider);
    final textTheme = Theme.of(context).textTheme;

    return !isJoined
        ? Container()
        : TextButton(
            onPressed: _confirmLeave,
            child: Text(
              "Leave",
              style: textTheme.titleMedium,
            ),
          );
  }

  void _confirmLeave() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AppDialog(
        title: LeaveButton.dialogTitle,
        content: LeaveButton.dialogContent,
        onConfirm: () => onConfirm(),
      ),
    );
  }

  void onConfirm() async {
    ref
        .read(challengeNotifierProvider.notifier)
        .leaveChallenge(widget.challenge.id);
    Navigator.pop(context);
  }
}
