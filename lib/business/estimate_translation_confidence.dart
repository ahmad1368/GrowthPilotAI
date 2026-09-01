/// Reports how much of a translated message the on-device dictionary
/// actually recognized (Issue #430, acceptance criterion 1) — an
/// honest confidence signal instead of an unverifiable "high
/// accuracy" claim.
class EstimateTranslationConfidence {
  static double call(int matchedWordCount, int totalWordCount) {
    if (totalWordCount == 0) return 0;
    return matchedWordCount / totalWordCount;
  }
}
