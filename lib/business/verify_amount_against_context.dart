import 'package:growth_pilot_ai/core/enum/match_confidence.dart';

/// Checks one AI-mentioned [amount] against the real [contextAmounts]
/// it should be grounded in (Issue #203's "Database Verification") —
/// exact match, a rounding-tolerant fuzzy match, or no correlation at
/// all ("Hallucination").
class VerifyAmountAgainstContext {
  static const fuzzyTolerance = 5.0; // dollars, e.g. "$452.80" said as "$450"

  static MatchConfidence call(double amount, List<double> contextAmounts) {
    if (contextAmounts.any((c) => c == amount)) return MatchConfidence.exact;
    if (contextAmounts.any((c) => (c - amount).abs() <= fuzzyTolerance)) {
      return MatchConfidence.fuzzy;
    }
    return MatchConfidence.mismatch;
  }
}
