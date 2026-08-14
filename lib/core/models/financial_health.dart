import 'package:flutter/foundation.dart';

/// Current-ratio-derived financial health snapshot (Issue #385).
@immutable
class FinancialHealth {
  final double currentAssets;
  final double currentLiabilities;
  final double workingCapital;
  final double currentRatio;
  final int healthScore;

  const FinancialHealth({
    required this.currentAssets,
    required this.currentLiabilities,
    required this.workingCapital,
    required this.currentRatio,
    required this.healthScore,
  });
}
