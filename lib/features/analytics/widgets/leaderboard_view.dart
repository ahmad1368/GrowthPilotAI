import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/build_leaderboard_narrative.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/leaderboard_row.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Renders a name filter, ranked rows, and a summary narrative (Issue
/// #408, acceptance criterion 4). Purely presentational.
class LeaderboardView extends StatelessWidget {
  final List<LeaderboardEntry> entries;
  final Set<int> verifiedRanks;
  final ValueChanged<String> onQueryChanged;
  final void Function(LeaderboardEntry) onVerify;

  const LeaderboardView({
    super.key,
    required this.entries,
    required this.verifiedRanks,
    required this.onQueryChanged,
    required this.onVerify,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShadInput(
            placeholder: const Text('Filter by merchant name'),
            onChanged: onQueryChanged),
        const SizedBox(height: 8),
        for (final entry in entries)
          LeaderboardRow(
            entry: entry,
            verified: verifiedRanks.contains(entry.rank),
            onVerify: () => onVerify(entry),
          ),
        const SizedBox(height: 8),
        Text(BuildLeaderboardNarrative.call(entries)),
      ],
    );
  }
}
