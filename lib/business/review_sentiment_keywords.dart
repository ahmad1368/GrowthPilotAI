/// Keyword lexicon for [ScoreReviewText] (Issue #358) — this app has no
/// NLP backend, so sentiment is approximated by counting known
/// positive/negative words instead of a trained model.
class ReviewSentimentKeywords {
  static const positive = {
    'great', 'excellent', 'love', 'good', 'friendly', 'fast', 'amazing',
    'helpful', 'fresh', 'clean', 'best', 'wonderful', 'awesome',
  };

  static const negative = {
    'bad', 'slow', 'rude', 'dirty', 'expensive', 'terrible', 'poor',
    'disappointed', 'broken', 'late', 'worst', 'awful', 'overpriced',
  };
}
