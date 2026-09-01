/// The "Helpfulness Score" (Issue #209 AC: "Construction AI
/// Helpfulness: 92%") — % of feedback events marked helpful. No
/// feedback yet is defined as 0, not a division-by-zero crash.
class ComputeHelpfulnessScore {
  static double call(List<bool> isHelpfulValues) {
    if (isHelpfulValues.isEmpty) return 0;
    final helpfulCount = isHelpfulValues.where((v) => v).length;
    return helpfulCount / isHelpfulValues.length * 100;
  }
}
