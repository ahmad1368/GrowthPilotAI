import 'dart:math';

/// "Data Perturbation" (Issue #80 scope item 4): nudges an amount by a
/// small random percentage so a large, unique transaction can't be
/// re-identified by matching its exact value in the anonymized dataset,
/// while staying within the AC's "2% accuracy" bound for aggregate
/// trends. [random] is injected so callers can get reproducible noise
/// in tests; production callers pass a real [Random].
class AddAmountNoise {
  static double call(double amount, Random random, {double maxNoisePercent = 0.01}) {
    final noiseFactor = 1 + (random.nextDouble() * 2 - 1) * maxNoisePercent;
    return amount * noiseFactor;
  }
}
