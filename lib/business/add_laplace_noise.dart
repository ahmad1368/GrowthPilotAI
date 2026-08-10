import 'dart:math';

/// Differential Privacy via the Laplace mechanism (Issue #91): perturbs an
/// aggregate count so a "Differencing Attack" (comparing the count before
/// and after one record changes) can't reveal whether a specific user
/// caused the change. [epsilon] is the privacy budget (lower = more
/// noise = more private); [sensitivity] is the max effect one record can
/// have on the true value (1 for a simple count). [random] is injected so
/// callers get reproducible noise in tests.
class AddLaplaceNoise {
  static int call(
    num trueValue,
    Random random, {
    double epsilon = 0.1,
    double sensitivity = 1,
  }) {
    final b = sensitivity / epsilon;
    final u = random.nextDouble() - 0.5;
    // Clamp away from the log(0) singularity at |u| == 0.5 — astronomically
    // rare from Random.nextDouble(), but must never produce NaN/-infinity.
    final safeMagnitude = max(1e-12, 1 - 2 * u.abs());
    final noise = -b * u.sign * log(safeMagnitude);
    final noisy = (trueValue + noise).round();
    return noisy < 0 ? 0 : noisy;
  }
}
