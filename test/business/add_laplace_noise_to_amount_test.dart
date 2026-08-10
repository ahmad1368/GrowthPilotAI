import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/add_laplace_noise_to_amount.dart';

void main() {
  test('is deterministic for a given Random state', () {
    final a = AddLaplaceNoiseToAmount.call(1000.0, Random(42));
    final b = AddLaplaceNoiseToAmount.call(1000.0, Random(42));
    expect(a, b);
  });

  test('never returns a negative amount, even for a true value of 0', () {
    final random = Random(7);
    for (var i = 0; i < 200; i++) {
      expect(AddLaplaceNoiseToAmount.call(0, random, epsilon: 0.5), greaterThanOrEqualTo(0));
    }
  });

  test('preserves decimal precision (does not round to a whole number)', () {
    final random = Random(11);
    final results = List.generate(
        50, (_) => AddLaplaceNoiseToAmount.call(1234.56, random, epsilon: 0.05));
    expect(results.any((v) => v != v.roundToDouble()), isTrue);
  });

  test('a very large epsilon adds negligible noise', () {
    final random = Random(3);
    for (var i = 0; i < 50; i++) {
      expect(AddLaplaceNoiseToAmount.call(10, random, epsilon: 1e6), closeTo(10, 0.001));
    }
  });
}
