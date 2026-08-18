import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_requirement_completeness.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeRequirementCompleteness', () {
    test('returns 0 for an empty list', () {
      expect(ComputeRequirementCompleteness.call(const <ExtractedRequirement>[]), 0);
    });

    test('returns the fraction of confirmed requirements', () {
      final rate = ComputeRequirementCompleteness.call([
        buildTestRequirement(status: RequirementTriageStatus.confirmed),
        buildTestRequirement(status: RequirementTriageStatus.edited),
        buildTestRequirement(status: RequirementTriageStatus.pending),
        buildTestRequirement(status: RequirementTriageStatus.confirmed),
      ]);

      expect(rate, 0.5);
    });
  });
}
