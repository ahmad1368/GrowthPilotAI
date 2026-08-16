/// Scales raw regression coefficients/importances to a relative [0, 1]
/// range (Issue #208's AC) — each value becomes its share of the total
/// magnitude, so the outputs sum to 1 (or all 0 when every input is 0).
class NormalizeFeatureWeights {
  static Map<String, double> call(Map<String, double> rawWeights) {
    final total = rawWeights.values.fold<double>(0, (sum, w) => sum + w.abs());
    if (total == 0) {
      return rawWeights.map((key, _) => MapEntry(key, 0.0));
    }
    return rawWeights.map((key, w) => MapEntry(key, w.abs() / total));
  }
}
