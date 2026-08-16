/// Rough token-count estimate for a string (Issue #199's "monitored via
/// a local tokenizer" AC) — no real tokenizer is integrated (see PR
/// notes), so this uses the common ~4-characters-per-token heuristic
/// for English text, rounded up.
class EstimateTokenCount {
  static int call(String text) => (text.length / 4).ceil();
}
