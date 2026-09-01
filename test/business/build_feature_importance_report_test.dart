import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_feature_importance_report.dart';

void main() {
  group('BuildFeatureImportanceReport', () {
    test('normalizes weights and identifies the top predictor', () {
      final report = BuildFeatureImportanceReport.call(
        fixedCosts: 0.15,
        variableCosts: 0.35,
        laborCosts: 0.45,
        externalFactors: 0.05,
        industryType: 'Construction',
      );

      expect(report.topFeature, 'labor_costs_weight');
      expect(report.laborCostsWeight, closeTo(0.45, 0.0001));
      expect(
        report.fixedCostsWeight +
            report.variableCostsWeight +
            report.laborCostsWeight +
            report.externalFactorsWeight,
        closeTo(1.0, 0.0001),
      );
    });

    test('carries the industryType through unchanged', () {
      final report = BuildFeatureImportanceReport.call(
        fixedCosts: 1,
        variableCosts: 1,
        laborCosts: 1,
        externalFactors: 1,
        industryType: 'Retail',
      );

      expect(report.industryType, 'Retail');
    });
  });
}
