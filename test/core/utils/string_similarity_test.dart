import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/string_similarity.dart';

void main() {
  group('StringSimilarity.compare', () {
    test('is 1.0 for identical strings (case-insensitive)', () {
      expect(StringSimilarity.compare('Fuel', 'fuel'), 1.0);
    });

    test('is 0.0 for completely unrelated short strings', () {
      expect(StringSimilarity.compare('ab', 'zz'), 0.0);
    });

    test('scores partial overlap between related category names', () {
      final score =
          StringSimilarity.compare('Food & Drink', 'Meals & Entertainment');
      expect(score, greaterThan(0.0));
      expect(score, lessThan(1.0));
    });

    test('is symmetric', () {
      final ab = StringSimilarity.compare('Travel', 'Travel: Fuel');
      final ba = StringSimilarity.compare('Travel: Fuel', 'Travel');
      expect(ab, ba);
    });
  });
}
