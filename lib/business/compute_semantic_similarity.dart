/// "Semantic Similarity" input (Issue #145) — this app has no OpenAI API
/// key or vector database, so intent-matching is approximated with
/// Jaccard word-overlap (a real, well-known baseline technique) rather
/// than fake embeddings.
class ComputeSemanticSimilarity {
  static double call(String textA, String textB) {
    final wordsA = _tokenize(textA);
    final wordsB = _tokenize(textB);
    if (wordsA.isEmpty || wordsB.isEmpty) return 0.0;

    final intersection = wordsA.intersection(wordsB).length;
    final union = wordsA.union(wordsB).length;
    return union == 0 ? 0.0 : intersection / union;
  }

  static Set<String> _tokenize(String text) => text
      .toLowerCase()
      .split(RegExp(r'[^a-z0-9]+'))
      .where((w) => w.isNotEmpty)
      .toSet();
}
