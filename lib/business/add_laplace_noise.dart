import 'dart:math';

import 'package:growth_pilot_ai/business/sample_laplace_noise.dart';

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
    final noise = SampleLaplaceNoise.call(random, epsilon: epsilon, sensitivity: sensitivity);
    final noisy = (trueValue + noise).round();
    return noisy < 0 ? 0 : noisy;
  }
}
