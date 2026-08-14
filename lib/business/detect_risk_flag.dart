/// "Conflict & Risk Detection" (Issue #152) — a fixed keyword list
/// stands in for real sentiment analysis, since no NLP API key exists.
class DetectRiskFlag {
  static const _keywords = ['scam', 'fraud', 'fake', 'lawsuit', 'threat', 'never pay', 'report you'];

  static bool call(String content) {
    final lower = content.toLowerCase();
    return _keywords.any(lower.contains);
  }
}
