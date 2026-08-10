import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/add_amount_noise.dart';

void main() {
  test('is deterministic for a given Random state', () {
    final a = AddAmountNoise.call(1000.0, Random(42));
    final b = AddAmountNoise.call(1000.0, Random(42));
    expect(a, b);
  });

  test('stays within the configured noise bound across many samples', () {
    const amount = 1000.0;
    final random = Random(7);
    for (var i = 0; i < 200; i++) {
      final noisy = AddAmountNoise.call(amount, random);
      expect(noisy, greaterThanOrEqualTo(amount * 0.99));
      expect(noisy, lessThanOrEqualTo(amount * 1.01));
    }
  });

  test('a zero amount stays zero regardless of noise factor', () {
    expect(AddAmountNoise.call(0, Random(1)), 0);
  });

  test('a custom noise bound is respected', () {
    const amount = 500.0;
    final random = Random(3);
    for (var i = 0; i < 50; i++) {
      final noisy = AddAmountNoise.call(amount, random, maxNoisePercent: 0.05);
      expect(noisy, greaterThanOrEqualTo(amount * 0.95));
      expect(noisy, lessThanOrEqualTo(amount * 1.05));
    }
  });
}
