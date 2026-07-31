import 'package:growth_pilot_ai/core/models/review_sentiment_result.dart';

/// One-sentence read naming the most negative and most positive logged
/// review (Issue #358).
class BuildReviewSentimentNarrative {
  static String call(List<ReviewSentimentResult> results) {
    if (results.isEmpty) {
      return 'No reviews logged yet — add one to start tracking sentiment.';
    }
    final worst = results.first;
    if (results.length == 1) {
      return worst.isNegative
          ? 'Latest review on ${worst.domain.name} reads negative — worth a look.'
          : 'Latest review on ${worst.domain.name} reads positive.';
    }
    final best = results.last;
    return 'Biggest concern is on ${worst.domain.name} — strongest praise is on ${best.domain.name}.';
  }
}
