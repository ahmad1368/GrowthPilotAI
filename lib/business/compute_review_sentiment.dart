import 'package:growth_pilot_ai/business/score_review_text.dart';
import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';
import 'package:growth_pilot_ai/core/models/review_sentiment_result.dart';

/// Scores each logged review's sentiment and sorts the most negative
/// reviews first (Issue #358) — surfacing operational deficiencies before
/// they compound, since this app has no automated alerting backend.
class ComputeReviewSentiment {
  static List<ReviewSentimentResult> call(List<ReviewFeedbackEntity> reviews) {
    final results = reviews.map((r) {
      return ReviewSentimentResult(
        reviewText: r.reviewText,
        domain: r.domain,
        submittedAt: r.submittedAt,
        sentimentScore: ScoreReviewText.call(r.reviewText),
      );
    }).toList();

    results.sort((a, b) => a.sentimentScore.compareTo(b.sentimentScore));
    return results;
  }
}
