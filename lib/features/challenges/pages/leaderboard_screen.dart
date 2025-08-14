import 'package:betterloop/features/challenges/providers/highlighted_participants_provider.dart';
import 'package:betterloop/features/challenges/providers/weekly_leaderboard_provider.dart';
import 'package:betterloop/models/challenge.dart';
import 'package:betterloop/models/participant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key, required this.challenge});
  final Challenge challenge;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenForLeaderboard(ref);
    final challengeId = challenge.id; // from navigation params or state
    final leaderboardAsync = ref.watch(weeklyLeaderboardProvider(challengeId));

    return leaderboardAsync.when(
      data: (data) => _buildList(data, ref),
      loading: () => Center(child: CircularProgressIndicator()),
      error: (err, _) => Text('Error: $err'),
    );
  }

  void listenForLeaderboard(WidgetRef ref) {
    ref.listen<List<RankGroup>>(
      weeklyLeaderboardProvider(challenge.id)
          .select((asyncValue) => asyncValue.asData?.value ?? []),
      (previous, next) {
        if (previous == null) return;
        if (previous.isEmpty || next.isEmpty) return;

        final newTopIds = next
            .expand((rankGroup) => rankGroup.participants)
            .map((p) => p.id)
            .toSet();

        final oldTopIds = previous
            .expand((rankGroup) => rankGroup.participants)
            .map((p) => p.id)
            .toSet();

        // IDs that are in new top 3 but not in old top 3
        final newlyRankedUp = newTopIds.difference(oldTopIds);

        if (newlyRankedUp.isNotEmpty) {
          // Store this set somewhere (like in a StateProvider) for highlighting in UI
          ref.read(highlightedParticipantsProvider.notifier).state =
              newlyRankedUp;
        }
      },
    );
  }

  Widget _buildList(List<RankGroup> ranks, WidgetRef ref) {
    if (ranks.isEmpty) {
      return const Center(child: Text("No participants yet"));
    }

    return ListView.builder(
      itemCount: ranks.length,
      itemBuilder: (context, index) {
        final rankGroup = ranks[index];
        final rankLabel =
            "${rankGroup.rank}${_rankSuffix(rankGroup.rank)} place";
        final participantsNames =
            rankGroup.participants.map((p) => p.displayName).join(", ");

        return ListTile(
          title: Text(rankLabel,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _buildDisplayName(rankGroup, ref),
          ),
          trailing: Text(
            "${rankGroup.participants.first.totalProgress}", // same for all in rank
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  List<Widget> _buildDisplayName(RankGroup group, WidgetRef ref) {
    final highlightedIds = ref.watch(highlightedParticipantsProvider);

    return group.participants.map((p) {
      final isHighlighted = highlightedIds.contains(p.id);
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color:
            isHighlighted ? Colors.yellow.withOpacity(0.3) : Colors.transparent,
        padding: EdgeInsets.all(8),
        child: Text(
          p.displayName,
          style: TextStyle(
            fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      );
    }).toList();
  }

  /// Helper to add ordinal suffix to ranks
  String _rankSuffix(int rank) {
    if (rank == 1) return "st";
    if (rank == 2) return "nd";
    if (rank == 3) return "rd";
    return "th";
  }
}
