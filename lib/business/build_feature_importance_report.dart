import 'package:growth_pilot_ai/business/find_top_feature.dart';
import 'package:growth_pilot_ai/business/normalize_feature_weights.dart';
import 'package:growth_pilot_ai/core/models/feature_importance_report.dart';

const _fixedKey = 'fixed_costs_weight';
const _variableKey = 'variable_costs_weight';
const _laborKey = 'labor_costs_weight';
const _externalKey = 'external_factors_weight';

/// Normalizes raw category coefficients into one [FeatureImportanceReport]
/// (Issue #208), combining [NormalizeFeatureWeights] + [FindTopFeature].
class BuildFeatureImportanceReport {
  static FeatureImportanceReport call({
    required double fixedCosts,
    required double variableCosts,
    required double laborCosts,
    required double externalFactors,
    required String industryType,
  }) {
    final normalized = NormalizeFeatureWeights.call({
      _fixedKey: fixedCosts,
      _variableKey: variableCosts,
      _laborKey: laborCosts,
      _externalKey: externalFactors,
    });

    return FeatureImportanceReport(
      fixedCostsWeight: normalized[_fixedKey]!,
      variableCostsWeight: normalized[_variableKey]!,
      laborCostsWeight: normalized[_laborKey]!,
      externalFactorsWeight: normalized[_externalKey]!,
      topFeature: FindTopFeature.call(normalized),
      industryType: industryType,
    );
  }
}
