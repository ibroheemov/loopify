import 'package:betterloop/features/settings/providers/last_backup_time_provider.dart';
import 'package:betterloop/theme/colors.dart';
import 'package:betterloop/theme/spacing.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class LastBackupTime extends ConsumerWidget {
  const LastBackupTime({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;

    final style = textTheme.titleMedium?.copyWith(
      color: AppColors.of(context).surfaceSecondary,
    );
    return ref.watch(lastBackupTimeProvider).when(
          data: (time) => Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Text(
              time == null ? 'No backup yet' : "Last backup: ${_result(time)}",
              style: style,
            ),
          ),
          loading: () => Text("Getting last backuptime...", style: style),
          error: (e, _) => Text('Failed: $e'),
        );
  }

  String _result(Timestamp timestamp) {
    final dateTime = timestamp.toDate();
    final formatted = DateFormat('MMM d h:mm a').format(dateTime);

    return formatted;
  }
}
