import 'package:flutter/material.dart';
import 'package:growth_pilot_ai/business/is_intelligence_pack_stale.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// "Last Synced: [Time]" freshness indicator (Issue #86 AC) — flat text,
/// switching to a warning tone once the pack passes the 30-day Kill
/// Switch threshold.
class PackSyncStatusBadge extends StatelessWidget {
  final DateTime lastSyncedAt;

  const PackSyncStatusBadge({super.key, required this.lastSyncedAt});

  @override
  Widget build(BuildContext context) {
    final colors = ShadTheme.of(context).colorScheme;
    final now = DateTime.now();
    final isStale = IsIntelligencePackStale.call(lastSyncedAt, now);
    final daysAgo = now.difference(lastSyncedAt).inDays;

    return Text(
      isStale
          ? 'Last synced $daysAgo days ago — data may be out of date'
          : 'Last synced $daysAgo day${daysAgo == 1 ? '' : 's'} ago',
      style: TextStyle(
        fontSize: 11,
        color: isStale ? colors.destructive : colors.mutedForeground,
      ),
    );
  }
}
