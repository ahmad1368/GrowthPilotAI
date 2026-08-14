import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/determine_intelligence_sync_state.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';

void main() {
  group('DetermineIntelligenceSyncState', () {
    final now = DateTime(2026, 8, 13, 12);

    test('returns syncing whenever a sync is in flight, regardless of age', () {
      final result = DetermineIntelligenceSyncState.call(
        isSyncing: true,
        lastSyncedAt: now.subtract(const Duration(days: 1)),
        now: now,
      );
      expect(result, IntelligenceSyncState.syncing);
    });

    test('returns updateRequired when no sync has ever happened', () {
      final result = DetermineIntelligenceSyncState.call(
        isSyncing: false,
        lastSyncedAt: null,
        now: now,
      );
      expect(result, IntelligenceSyncState.updateRequired);
    });

    test('returns updateRequired once the 6-hour cadence has elapsed', () {
      final result = DetermineIntelligenceSyncState.call(
        isSyncing: false,
        lastSyncedAt: now.subtract(const Duration(hours: 6)),
        now: now,
      );
      expect(result, IntelligenceSyncState.updateRequired);
    });

    test('returns localMode when synced within the 6-hour cadence', () {
      final result = DetermineIntelligenceSyncState.call(
        isSyncing: false,
        lastSyncedAt: now.subtract(const Duration(hours: 5)),
        now: now,
      );
      expect(result, IntelligenceSyncState.localMode);
    });
  });
}
