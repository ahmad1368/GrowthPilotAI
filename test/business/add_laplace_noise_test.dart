import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/add_laplace_noise.dart';

void main() {
  test('is deterministic for a given Random state', () {
    final a = AddLaplaceNoise.call(10, Random(42));
    final b = AddLaplaceNoise.call(10, Random(42));
    expect(a, b);
  });

  test('never returns a negative count, even for a true value of 0', () {
    final random = Random(7);
    for (var i = 0; i < 200; i++) {
      expect(AddLaplaceNoise.call(0, random, epsilon: 0.5), greaterThanOrEqualTo(0));
    }
  });

  // A near-infinite privacy budget means near-zero noise: the mechanism
  // must reduce to (approximately) the true value.
  test('a very large epsilon adds negligible noise', () {
    final random = Random(3);
    for (var i = 0; i < 50; i++) {
      expect(AddLaplaceNoise.call(10, random, epsilon: 1e6), 10);
    }
  });

  test('a small epsilon (tight privacy budget) can perturb the value', () {
    final random = Random(11);
    final results = List.generate(50, (_) => AddLaplaceNoise.call(10, random, epsilon: 0.05));
    expect(results.toSet().length, greaterThan(1));
  });
}
