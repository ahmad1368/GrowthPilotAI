import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

/// "Duplicate Detection" (Issue #228) — keeps the first occurrence of
/// each requirement whose description is identical once whitespace-
/// normalized and lowercased. This is exact/near-duplicate matching,
/// not the issue's Vector Similarity (Cosine Similarity) over real
/// embeddings — this repo's embedding service is a mock (see #83's
/// prior disclosure), so it cannot back a genuine semantic-similarity
/// merge without misrepresenting what it does.
class DeduplicateRequirements {
  static List<ExtractedRequirement> call(List<ExtractedRequirement> requirements) {
    final seen = <String>{};
    final result = <ExtractedRequirement>[];

    for (final requirement in requirements) {
      final key = requirement.description.toLowerCase().replaceAll(RegExp(r'\s+'), ' ').trim();
      if (seen.add(key)) result.add(requirement);
    }
    return result;
  }
}
