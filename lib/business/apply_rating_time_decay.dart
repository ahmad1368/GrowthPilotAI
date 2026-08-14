import 'dart:math' as math;

/// "Recency Decay Function" (Issue #125): a 5%-per-month exponential
/// decay, matching the issue's own `RatingEngine.applyTimeDecay` code
/// sample (≈26-30% weaker by the 6-month mark it describes in prose).
class ApplyRatingTimeDecay {
  static double call(DateTime ratedAt, double score, DateTime now) {
    final monthsOld = _monthsBetween(ratedAt, now);
    final decayFactor = math.pow(0.95, monthsOld).toDouble();
    return score * decayFactor;
  }

  static int _monthsBetween(DateTime from, DateTime to) {
    final months = (to.year - from.year) * 12 + (to.month - from.month);
    return months < 0 ? 0 : months;
  }
}
