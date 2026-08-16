/// Finds the highest-weighted key in a normalized feature-importance map
/// (Issue #208) — the "top_predictor" driving a cost prediction.
class FindTopFeature {
  static String call(Map<String, double> weights) {
    return weights.entries.reduce((a, b) => a.value >= b.value ? a : b).key;
  }
}
