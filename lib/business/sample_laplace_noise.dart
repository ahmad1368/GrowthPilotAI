import 'dart:math';

/// Raw Laplace-distributed noise sample via inverse-CDF sampling (Issue
/// #91's numerically-guarded formula), shared by [AddLaplaceNoise]
/// (integer counts) and [AddLaplaceNoiseToAmount] (Issue #82, decimal
/// amounts) so both consumers use one implementation of the math.
class SampleLaplaceNoise {
  static double call(Random random, {double epsilon = 0.1, double sensitivity = 1}) {
    final b = sensitivity / epsilon;
    final u = random.nextDouble() - 0.5;
    // Clamp away from the log(0) singularity at |u| == 0.5 — astronomically
    // rare from Random.nextDouble(), but must never produce NaN/-infinity.
    final safeMagnitude = max(1e-12, 1 - 2 * u.abs());
    return -b * u.sign * log(safeMagnitude);
  }
}
