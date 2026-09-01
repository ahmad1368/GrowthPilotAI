import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_query_date_range.dart';

void main() {
  group('ExtractQueryDateRange', () {
    final now = DateTime(2026, 4, 15);

    test('returns null when no timeframe is mentioned', () {
      expect(ExtractQueryDateRange.call('how much did I spend on fuel', now), isNull);
    });

    test('parses "last N days"', () {
      final range = ExtractQueryDateRange.call('spending in the last 30 days', now)!;
      expect(range.$1, now.subtract(const Duration(days: 30)));
      expect(range.$2, now);
    });

    test('parses "last month" across a year boundary', () {
      final january = DateTime(2026, 1, 15);
      final range = ExtractQueryDateRange.call('last month spend', january)!;
      expect(range.$1, DateTime(2025, 12, 1));
      expect(range.$2.isBefore(DateTime(2026, 1, 1)), isTrue);
    });

    test('parses "last quarter" across a year boundary', () {
      final january = DateTime(2026, 1, 15);
      final range = ExtractQueryDateRange.call('last quarter results', january)!;
      expect(range.$1, DateTime(2025, 10, 1));
    });

    test('parses a bare month name to its most recent occurrence', () {
      final range = ExtractQueryDateRange.call('Summarize my spending in March', now)!;
      expect(range.$1, DateTime(2026, 3, 1));
    });

    test('a month name later in the year resolves to last year', () {
      final range = ExtractQueryDateRange.call('spending in December', now)!;
      expect(range.$1, DateTime(2025, 12, 1));
    });
  });
}
