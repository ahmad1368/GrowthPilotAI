import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';

/// One-sentence read summarizing sponsored vs organic leaderboard
/// composition (Issue #408), mirroring [BuildAdRequestNarrative]'s
/// summary pattern.
class BuildLeaderboardNarrative {
  static String call(List<LeaderboardEntry> entries) {
    if (entries.isEmpty) {
      return 'No ranked merchants yet.';
    }
    final sponsoredCount = entries.where((e) => e.isSponsored).length;
    if (sponsoredCount == 0) {
      return 'Ranking ${entries.length} merchant(s) organically; no sponsored placements.';
    }
    return '$sponsoredCount sponsored placement(s) pinned above '
        '${entries.length - sponsoredCount} organically ranked merchant(s).';
  }
}
