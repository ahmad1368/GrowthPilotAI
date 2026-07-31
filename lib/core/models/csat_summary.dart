/// Aggregated CSAT read across all logged ratings (Issue #375): the
/// average score and a simple recent-vs-earlier trend delta.
class CsatSummary {
  final double averageScore;
  final int totalRatings;
  final double trendDelta;

  const CsatSummary({
    required this.averageScore,
    required this.totalRatings,
    required this.trendDelta,
  });

  bool get isImproving => trendDelta > 0;
}
