import 'package:growth_pilot_ai/core/data/entities/review_feedback_entity.dart';

/// One logged review's keyword-scored sentiment read (Issue #358).
class ReviewSentimentResult {
  final String reviewText;
  final FeedbackDomain domain;
  final DateTime submittedAt;
  final int sentimentScore;

  const ReviewSentimentResult({
    required this.reviewText,
    required this.domain,
    required this.submittedAt,
    required this.sentimentScore,
  });

  bool get isPositive => sentimentScore > 0;
  bool get isNegative => sentimentScore < 0;
}
