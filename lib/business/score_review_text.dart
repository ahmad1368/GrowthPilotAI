import 'package:growth_pilot_ai/business/review_sentiment_keywords.dart';

/// Scores one review's text as (positive word matches - negative word
/// matches) (Issue #358) — a keyword-based approximation since this app
/// has no NLP backend to source a trained sentiment score from.
class ScoreReviewText {
  static int call(String text) {
    final words = text.toLowerCase().split(RegExp(r'[^a-z]+'));
    var score = 0;
    for (final word in words) {
      if (ReviewSentimentKeywords.positive.contains(word)) score++;
      if (ReviewSentimentKeywords.negative.contains(word)) score--;
    }
    return score;
  }
}
