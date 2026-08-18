import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_project_metrics.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeProjectMetrics', () {
    test('aggregates every KPI into one snapshot', () {
      final snapshot = ComputeProjectMetrics.call([
        buildTestRequirement(type: RequirementType.functional),
        buildTestRequirement(type: RequirementType.nonFunctional),
      ]);

      expect(snapshot.totalRequirements, 2);
      expect(snapshot.requirementCounts[RequirementType.functional], 1);
      expect(snapshot.riskScore, 0);
      expect(snapshot.complexityIndex, 0);
    });
  });
}
