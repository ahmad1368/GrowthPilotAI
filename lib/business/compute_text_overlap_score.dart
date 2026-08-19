import 'package:growth_pilot_ai/business/find_shared_keywords.dart';

/// "Vector Similarity Scoring... Cosine Similarity" (Issue #244) — this
/// repo's #198/#230 embeddings are an explicitly non-semantic mock (see
/// their own doc comments), so scoring suggested links on them would
/// be no better than chance. This uses Jaccard similarity over
/// significant words instead: a real, deterministic lexical-overlap
/// signal, not a real vector/LLM semantic score (see PR notes).
class ComputeTextOverlapScore {
  static double call(String textA, String textB) {
    final wordsA = FindSharedKeywords.wordsOf(textA);
    final wordsB = FindSharedKeywords.wordsOf(textB);
    if (wordsA.isEmpty || wordsB.isEmpty) return 0;
    final intersection = wordsA.intersection(wordsB).length;
    final union = wordsA.union(wordsB).length;
    return intersection / union;
  }
}
