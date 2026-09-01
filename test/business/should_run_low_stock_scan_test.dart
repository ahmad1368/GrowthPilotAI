import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/should_run_low_stock_scan.dart';

void main() {
  group('ShouldRunLowStockScan', () {
    final now = DateTime(2026, 8, 22, 12);

    test('runs when no scan has ever happened (Issue #440 AC 2)', () {
      expect(ShouldRunLowStockScan.call(null, now), isTrue);
    });

    test('does not run before the 6-hour interval has elapsed', () {
      expect(ShouldRunLowStockScan.call(now.subtract(const Duration(hours: 5)), now), isFalse);
    });

    test('runs once the 6-hour interval has elapsed', () {
      expect(ShouldRunLowStockScan.call(now.subtract(const Duration(hours: 6)), now), isTrue);
    });
  });
}
