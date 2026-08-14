import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/financial_dna_dimension.dart';

/// Result of [DetectSuccessPattern] (Issue #83) — [divergentDimension]
/// is only set when the pattern doesn't match, driving the "Course
/// Correction" tip.
@immutable
class SuccessPatternResult {
  final double similarityScore;
  final bool isHighGrowthMatch;
  final FinancialDnaDimension? divergentDimension;

  const SuccessPatternResult({
    required this.similarityScore,
    required this.isHighGrowthMatch,
    this.divergentDimension,
  });
}
