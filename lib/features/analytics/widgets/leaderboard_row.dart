import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/core/models/leaderboard_entry.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// One leaderboard row (Issue #408) — sponsored rows show a distinct
/// tag plus a Verify action that checks and audit-logs the placement's
/// legitimacy (acceptance criteria 3 and 5).
class LeaderboardRow extends StatelessWidget {
  final LeaderboardEntry entry;
  final bool verified;
  final VoidCallback onVerify;

  const LeaderboardRow(
      {super.key, required this.entry, required this.verified, required this.onVerify});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              entry.isSponsored
                  ? '#${entry.rank} ${entry.name}'
                  : '#${entry.rank} ${entry.name} — score ${entry.score.toStringAsFixed(0)}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (entry.isSponsored) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                border: Border.all(color: scheme.onSurface.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text('Sponsored', style: TextStyle(fontSize: 11)),
            ),
            const SizedBox(width: 8),
            verified
                ? Text('Verified', style: TextStyle(color: scheme.onSurface, fontSize: 12))
                : ShadButton.ghost(onPressed: onVerify, child: const Text('Verify')),
          ],
        ],
      ),
    );
  }
}
