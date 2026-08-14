import 'dart:math';

import 'package:growth_pilot_ai/business/sample_laplace_noise.dart';

/// Like [AddLaplaceNoise] but for a continuous monetary amount rather
/// than an integer count (Issue #82: "average monthly burn rate") — no
/// rounding to the nearest whole unit, since a dollar benchmark losing
/// cents isn't the same tradeoff as a noised count losing fractions.
class AddLaplaceNoiseToAmount {
  static double call(
    double trueValue,
    Random random, {
    double epsilon = 0.1,
    double sensitivity = 1,
  }) {
    final noise = SampleLaplaceNoise.call(random, epsilon: epsilon, sensitivity: sensitivity);
    final noisy = trueValue + noise;
    return noisy < 0 ? 0 : noisy;
  }
}
