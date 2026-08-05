/// One ranked row on the Top Ranks Leaderboard (Issue #408) — sponsored
/// entries are tagged so the UI can render the disclosure label
/// (acceptance criterion 3) and [VerifySponsoredPlacement] can attribute
/// the override back to its advertising request (acceptance criterion
/// 5), mirroring [SearchResultItem]'s (#404) sponsored-tagging shape.
class LeaderboardEntry {
  final int rank;
  final String name;
  final double score;
  final bool isSponsored;
  final int? sourceRequestId;

  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.score,
    required this.isSponsored,
    this.sourceRequestId,
  });
}
