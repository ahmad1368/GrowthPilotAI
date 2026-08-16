import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_query_intent.dart';

void main() {
  group('ParseQueryIntent', () {
    final now = DateTime(2026, 4, 15);

    test('extracts timeframe, category, and location together', () {
      final intent = ParseQueryIntent.call('How much did I spend on fuel in Surrey last month?', now);

      expect(intent.rangeStart, DateTime(2026, 3, 1));
      expect(intent.category, 'fuel');
      expect(intent.location, 'surrey');
    });

    test('leaves unmentioned facets null instead of guessing', () {
      final intent = ParseQueryIntent.call('What is my total balance?', now);

      expect(intent.rangeStart, isNull);
      expect(intent.category, isNull);
      expect(intent.location, isNull);
    });
  });
}
