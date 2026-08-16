import 'package:get_it/get_it.dart';
import 'package:growth_pilot_ai/business/build_feature_importance_report.dart';
import 'package:growth_pilot_ai/core/data/entities/feature_importance_report_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/feature_importance_report_repository.dart';
import 'package:growth_pilot_ai/core/models/feature_importance_report.dart';

/// Builds and persists one prediction's feature-importance report (Issue
/// #208) — no per-category regression coefficients exist yet to extract
/// automatically (see [BuildFeatureImportanceReport]'s doc comment), so raw
/// weights must be supplied by the caller until that model exists.
class RecordFeatureImportanceReport {
  static FeatureImportanceReport call({
    required double fixedCosts,
    required double variableCosts,
    required double laborCosts,
    required double externalFactors,
    required String industryType,
  }) {
    final report = BuildFeatureImportanceReport.call(
      fixedCosts: fixedCosts,
      variableCosts: variableCosts,
      laborCosts: laborCosts,
      externalFactors: externalFactors,
      industryType: industryType,
    );

    GetIt.I<FeatureImportanceReportRepository>().add(FeatureImportanceReportEntity(
      fixedCostsWeight: report.fixedCostsWeight,
      variableCostsWeight: report.variableCostsWeight,
      laborCostsWeight: report.laborCostsWeight,
      externalFactorsWeight: report.externalFactorsWeight,
      topFeature: report.topFeature,
      industryType: report.industryType,
      createdAt: DateTime.now(),
    ));

    return report;
  }
}
