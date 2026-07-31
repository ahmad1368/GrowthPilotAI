import 'package:growth_pilot_ai/core/models/csat_summary.dart';

/// One-sentence read on average CSAT and its recent trend (Issue #375).
class BuildCsatNarrative {
  static String call(CsatSummary summary) {
    if (summary.totalRatings == 0) {
      return 'No CSAT ratings logged yet — add one to start tracking satisfaction.';
    }
    final trend = summary.trendDelta > 0.05
        ? 'trending up'
        : summary.trendDelta < -0.05
            ? 'trending down'
            : 'holding steady';
    return 'Average satisfaction is ${summary.averageScore.toStringAsFixed(1)}/5 '
        'across ${summary.totalRatings} ratings, $trend.';
  }
}
