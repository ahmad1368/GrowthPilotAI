import 'dart:math';

/// Cosine similarity between two equal-length vectors (Issue #83 scope
/// item 3) — 1.0 means identical direction, 0.0 means no correlation.
class ComputeCosineSimilarity {
  static double call(List<double> a, List<double> b) {
    assert(a.length == b.length, 'Vectors must be the same length.');
    var dot = 0.0, normA = 0.0, normB = 0.0;
    for (var i = 0; i < a.length; i++) {
      dot += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }
    if (normA == 0 || normB == 0) return 0;
    return dot / (sqrt(normA) * sqrt(normB));
  }
}
