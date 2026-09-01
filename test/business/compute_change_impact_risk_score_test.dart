import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_change_impact_risk_score.dart';

void main() {
  group('ComputeChangeImpactRiskScore', () {
    test('returns 0 for a fully isolated requirement', () {
      final score = ComputeChangeImpactRiskScore.call(
          directGoalCount: 0, directTestCaseCount: 0, indirectRequirementCount: 0, contradictionCount: 0);

      expect(score, 0);
    });

    test('weighs each factor and clamps at 100', () {
      final score = ComputeChangeImpactRiskScore.call(
          directGoalCount: 3, directTestCaseCount: 2, indirectRequirementCount: 1, contradictionCount: 5);

      expect(score, 100);
    });

    test('sums the weighted factors below the clamp', () {
      final score = ComputeChangeImpactRiskScore.call(
          directGoalCount: 1, directTestCaseCount: 1, indirectRequirementCount: 0, contradictionCount: 0);

      expect(score, 25);
    });
  });
}
