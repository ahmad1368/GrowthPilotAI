import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_requirement_volatility.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeRequirementVolatility', () {
    test('returns 0 for an empty list', () {
      expect(ComputeRequirementVolatility.call(const <ExtractedRequirement>[]), 0);
    });

    test('returns the fraction of requirements moved off pending', () {
      final rate = ComputeRequirementVolatility.call([
        buildTestRequirement(status: RequirementTriageStatus.confirmed),
        buildTestRequirement(status: RequirementTriageStatus.pending),
      ]);

      expect(rate, 0.5);
    });
  });
}
