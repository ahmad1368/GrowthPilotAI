import 'package:growth_pilot_ai/business/compute_cosine_similarity.dart';
import 'package:growth_pilot_ai/core/data/entities/embedding_entity.dart';

/// Brute-force nearest-neighbor search (Issue #198's "Top-k... most
/// relevant transaction fragments") — a linear cosine-similarity scan
/// rather than ObjectBox's native HNSW index, since this repo's pinned
/// `objectbox` version (2.5.1) doesn't support vector indexing yet
/// (see PR notes). Fine at the "thousands of records" scale the issue
/// targets; revisit if that grows much further.
class RetrieveTopKContext {
  static List<EmbeddingEntity> call(
      List<double> queryVector, List<EmbeddingEntity> candidates, int k) {
    final scored = candidates
        .map((c) => MapEntry(c, ComputeCosineSimilarity.call(queryVector, c.embedding)))
        .toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return scored.take(k).map((e) => e.key).toList();
  }
}
