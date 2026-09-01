import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/normalize_feature_weights.dart';

void main() {
  group('NormalizeFeatureWeights', () {
    test('scales values to their relative share of the total', () {
      final result = NormalizeFeatureWeights.call({'a': 0.15, 'b': 0.45, 'c': 0.35, 'd': 0.05});

      expect(result['a'], closeTo(0.15, 0.0001));
      expect(result['b'], closeTo(0.45, 0.0001));
      expect(result.values.fold<double>(0, (sum, w) => sum + w), closeTo(1.0, 0.0001));
    });

    test('every value lands in [0, 1]', () {
      final result = NormalizeFeatureWeights.call({'a': 2.0, 'b': 8.0});

      expect(result['a'], closeTo(0.2, 0.0001));
      expect(result['b'], closeTo(0.8, 0.0001));
    });

    test('all-zero input returns all zeros instead of dividing by zero', () {
      final result = NormalizeFeatureWeights.call({'a': 0.0, 'b': 0.0});

      expect(result['a'], 0);
      expect(result['b'], 0);
    });

    test('negative coefficients are normalized by magnitude', () {
      final result = NormalizeFeatureWeights.call({'a': -0.4, 'b': 0.6});

      expect(result['a'], closeTo(0.4, 0.0001));
      expect(result['b'], closeTo(0.6, 0.0001));
    });
  });
}
