import 'package:flutter/foundation.dart';

/// Where the average basket price sits relative to regional purchasing
/// power (Issue #397).
enum AffordabilityTier { underpriced, aligned, overpriced }

/// Result of comparing local basket pricing against a regional income
/// benchmark (Issue #397).
@immutable
class RegionalAffordabilityResult {
  final double averageBasketPrice;
  final double medianMonthlyIncome;
  final double affordabilityIndex;
  final AffordabilityTier tier;

  const RegionalAffordabilityResult({
    required this.averageBasketPrice,
    required this.medianMonthlyIncome,
    required this.affordabilityIndex,
    required this.tier,
  });
}
