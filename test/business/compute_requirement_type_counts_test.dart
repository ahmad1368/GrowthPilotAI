import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_requirement_type_counts.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('ComputeRequirementTypeCounts', () {
    test('tallies each requirement by its type', () {
      final counts = ComputeRequirementTypeCounts.call([
        buildTestRequirement(type: RequirementType.functional),
        buildTestRequirement(type: RequirementType.functional),
        buildTestRequirement(type: RequirementType.nonFunctional),
      ]);

      expect(counts[RequirementType.functional], 2);
      expect(counts[RequirementType.nonFunctional], 1);
      expect(counts[RequirementType.technical], 0);
    });

    test('includes every type with zero for an empty list', () {
      final counts = ComputeRequirementTypeCounts.call(const <ExtractedRequirement>[]);

      expect(counts.length, RequirementType.values.length);
      expect(counts.values.every((c) => c == 0), isTrue);
    });
  });
}
