import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_mape.dart';

void main() {
  group('ComputeMape', () {
    test('0% when the prediction was exact', () {
      expect(ComputeMape.call(1000, 1000), 0);
    });

    test('computes the standard percentage error', () {
      expect(ComputeMape.call(1000, 1200), 20);
    });

    test('the formula uses absolute value regardless of over/under-prediction', () {
      expect(ComputeMape.call(1000, 800), 20);
    });

    test('zero actual with zero predicted is 0%, not a division-by-zero crash', () {
      expect(ComputeMape.call(0, 0), 0);
    });

    test('zero actual with a nonzero prediction is a total (100%) miss', () {
      expect(ComputeMape.call(0, 500), 100);
    });
  });
}
