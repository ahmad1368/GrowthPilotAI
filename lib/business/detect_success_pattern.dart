import 'package:growth_pilot_ai/business/compute_cosine_similarity.dart';
import 'package:growth_pilot_ai/business/find_most_divergent_dimension.dart';
import 'package:growth_pilot_ai/core/models/financial_dna_vector.dart';
import 'package:growth_pilot_ai/core/models/success_pattern_result.dart';

/// The "Pattern Recognition" comparison (Issue #83 scope item 3): cosine
/// similarity between the user's and sector's Financial DNA vectors,
/// thresholded per the issue's own `score > 0.9` example.
class DetectSuccessPattern {
  static SuccessPatternResult call(
    FinancialDnaVector userVector,
    FinancialDnaVector successVector, {
    double matchThreshold = 0.9,
  }) {
    final score = ComputeCosineSimilarity.call(userVector.toList(), successVector.toList());
    final isMatch = score > matchThreshold;
    return SuccessPatternResult(
      similarityScore: score,
      isHighGrowthMatch: isMatch,
      divergentDimension:
          isMatch ? null : FindMostDivergentDimension.call(userVector, successVector),
    );
  }
}
