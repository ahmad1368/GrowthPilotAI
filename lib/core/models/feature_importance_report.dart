import 'package:flutter/foundation.dart';

/// One `feature_importance_report` result (Issue #208) — the raw
/// coefficients/importances behind [fixedCostsWeight]/[variableCostsWeight]/
/// [laborCostsWeight]/[externalFactorsWeight] are caller-supplied, not
/// extracted from a real per-category regression model (see PR notes:
/// [lib/core/utils/forecast_engine.dart] is a single-variable time-series
/// regression with no category coefficients to read). Only relative
/// category weights are stored, never dollar amounts (AC: "Zero PII").
@immutable
class FeatureImportanceReport {
  final double fixedCostsWeight;
  final double variableCostsWeight;
  final double laborCostsWeight;
  final double externalFactorsWeight;
  final String topFeature;
  final String industryType;

  const FeatureImportanceReport({
    required this.fixedCostsWeight,
    required this.variableCostsWeight,
    required this.laborCostsWeight,
    required this.externalFactorsWeight,
    required this.topFeature,
    required this.industryType,
  });
}
