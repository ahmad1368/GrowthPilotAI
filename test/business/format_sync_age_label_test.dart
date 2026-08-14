import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/format_sync_age_label.dart';

void main() {
  group('FormatSyncAgeLabel', () {
    final now = DateTime(2026, 8, 13, 12);

    test('reports "just now" for sub-minute gaps', () {
      final result = FormatSyncAgeLabel.call(now.subtract(const Duration(seconds: 30)), now);
      expect(result, 'just now');
    });

    test('reports minutes for sub-hour gaps', () {
      final result = FormatSyncAgeLabel.call(now.subtract(const Duration(minutes: 15)), now);
      expect(result, '15m ago');
    });

    test('reports hours for sub-day gaps', () {
      final result = FormatSyncAgeLabel.call(now.subtract(const Duration(hours: 4)), now);
      expect(result, '4h ago');
    });

    test('reports days for multi-day gaps', () {
      final result = FormatSyncAgeLabel.call(now.subtract(const Duration(days: 2)), now);
      expect(result, '2d ago');
    });
  });
}
