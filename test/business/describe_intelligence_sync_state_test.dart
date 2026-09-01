import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/describe_intelligence_sync_state.dart';
import 'package:growth_pilot_ai/core/enum/intelligence_sync_state.dart';

void main() {
  group('DescribeIntelligenceSyncState', () {
    final now = DateTime(2026, 8, 13, 12);

    test('describes the syncing state regardless of lastSyncedAt', () {
      final result =
          DescribeIntelligenceSyncState.call(IntelligenceSyncState.syncing, null, now);
      expect(result, 'Optimizing local data…');
    });

    test('describes updateRequired plainly, without exposing raw timestamps', () {
      final result = DescribeIntelligenceSyncState.call(
          IntelligenceSyncState.updateRequired, now.subtract(const Duration(days: 3)), now);
      expect(result, 'Update required');
    });

    test('describes localMode with no prior sync as "Local Intelligence"', () {
      final result =
          DescribeIntelligenceSyncState.call(IntelligenceSyncState.localMode, null, now);
      expect(result, 'Local Intelligence');
    });

    test('describes localMode with a prior sync using the relative age label', () {
      final result = DescribeIntelligenceSyncState.call(
          IntelligenceSyncState.localMode, now.subtract(const Duration(hours: 2)), now);
      expect(result, 'Local Intel: 2h ago');
    });
  });
}
