import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_requirement_engagement.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeRequirementEngagement', () {
    test('returns 0 for an empty list', () {
      expect(ComputeRequirementEngagement.call(const <ExtractedRequirement>[]), 0);
    });

    test('returns the fraction assigned a real stakeholder', () {
      final rate = ComputeRequirementEngagement.call([
        buildTestRequirement(stakeholder: 'Finance'),
        buildTestRequirement(stakeholder: 'Unassigned'),
      ]);

      expect(rate, 0.5);
    });
  });
}
