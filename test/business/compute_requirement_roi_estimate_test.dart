import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_requirement_roi_estimate.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeRequirementRoiEstimate', () {
    test('returns 0 for an empty list', () {
      expect(ComputeRequirementRoiEstimate.call(const <ExtractedRequirement>[]), 0);
    });

    test('weighs Must-Have fully and Should-Have at half', () {
      final roi = ComputeRequirementRoiEstimate.call([
        buildTestRequirement(moscowPriority: RequirementMoscowPriority.mustHave),
        buildTestRequirement(moscowPriority: RequirementMoscowPriority.shouldHave),
        buildTestRequirement(moscowPriority: RequirementMoscowPriority.wontHave),
      ]);

      expect(roi, closeTo(0.5, 0.001));
    });
  });
}
