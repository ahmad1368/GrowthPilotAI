import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_requirements_by_stakeholder_and_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';

import 'requirement_test_fixtures.dart';

void main() {
  group('GroupRequirementsByStakeholderAndPriority', () {
    test('tallies each stakeholder group by every MoSCoW tier', () {
      final grouped = GroupRequirementsByStakeholderAndPriority.call([
        buildTestRequirement(
            stakeholder: 'Finance', moscowPriority: RequirementMoscowPriority.mustHave),
        buildTestRequirement(
            stakeholder: 'Finance', moscowPriority: RequirementMoscowPriority.mustHave),
        buildTestRequirement(
            stakeholder: 'Sales', moscowPriority: RequirementMoscowPriority.couldHave),
      ]);

      expect(grouped['Finance']?[RequirementMoscowPriority.mustHave], 2);
      expect(grouped['Finance']?[RequirementMoscowPriority.shouldHave], 0);
      expect(grouped['Sales']?[RequirementMoscowPriority.couldHave], 1);
    });

    test('returns an empty map for an empty list', () {
      expect(GroupRequirementsByStakeholderAndPriority.call(const []), isEmpty);
    });
  });
}
