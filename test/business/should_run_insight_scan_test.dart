import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_run_insight_scan.dart';

void main() {
  group('ShouldRunInsightScan', () {
    final now = DateTime(2026, 8, 13, 12);

    test('runs when no scan has ever happened', () {
      expect(ShouldRunInsightScan.call(null, now), isTrue);
    });

    test('does not run before the 3-hour interval has elapsed', () {
      expect(ShouldRunInsightScan.call(now.subtract(const Duration(hours: 2)), now), isFalse);
    });

    test('runs once the 3-hour interval has elapsed', () {
      expect(ShouldRunInsightScan.call(now.subtract(const Duration(hours: 3)), now), isTrue);
    });

    test('honors an overridden interval (Issue #110 throttling) over the 3-hour default', () {
      final lastScanAt = now.subtract(const Duration(hours: 4));
      expect(
        ShouldRunInsightScan.call(lastScanAt, now, interval: const Duration(hours: 6)),
        isFalse,
      );
    });
  });
}
