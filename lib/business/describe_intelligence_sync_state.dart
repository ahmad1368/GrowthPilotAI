import 'package:growth_pilot_ai/business/format_sync_age_label.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';

/// User-facing label for the Offline Intelligence badge (Issue #109) — no
/// raw DB names or hashes (AC: "Privacy Integrity"), just plain English.
class DescribeIntelligenceSyncState {
  static String call(IntelligenceSyncState state, DateTime? lastSyncedAt, DateTime now) {
    switch (state) {
      case IntelligenceSyncState.syncing:
        return 'Optimizing local data…';
      case IntelligenceSyncState.updateRequired:
        return 'Update required';
      case IntelligenceSyncState.localMode:
        return lastSyncedAt == null
            ? 'Local Intelligence'
            : 'Local Intel: ${FormatSyncAgeLabel.call(lastSyncedAt, now)}';
    }
  }
}
