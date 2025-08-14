class Participant {
  final String id;
  final String displayName;
  final int totalProgress;

  Participant({
    required this.id,
    required this.displayName,
    required this.totalProgress,
  });
}

class RankGroup {
  final int rank;
  final List<Participant> participants;
  RankGroup({required this.rank, required this.participants});
}
