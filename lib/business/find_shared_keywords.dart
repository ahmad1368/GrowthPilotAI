/// Significant (non-stopword, length >= 4) lowercase words shared
/// between two texts (Issue #244's suggestion "AI Reasoning" —
/// "Both mention 'Data Latency' and 'User Response Time'" — actually
/// computed via lexical overlap, not an LLM; see PR notes).
class FindSharedKeywords {
  static const _stopwords = {
    'that', 'this', 'with', 'from', 'shall', 'must', 'should', 'will',
    'system', 'user', 'users', 'requirement', 'business', 'goal', 'ensure',
    'provide', 'support', 'have', 'able', 'when', 'their', 'each', 'also',
  };

  /// Public so [ComputeTextOverlapScore] can reuse the same word set
  /// without duplicating the stopword logic.
  static Set<String> wordsOf(String text) {
    return text
        .toLowerCase()
        .split(RegExp(r'[^a-z0-9]+'))
        .where((w) => w.length >= 4 && !_stopwords.contains(w))
        .toSet();
  }

  static List<String> call(String textA, String textB) {
    return wordsOf(textA).intersection(wordsOf(textB)).toList()..sort();
  }
}
