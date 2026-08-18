import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/group_requirements_by_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

ExtractedRequirement _req(RequirementMoscowPriority priority) => ExtractedRequirement(
      description: 'x',
      type: RequirementType.functional,
      indicator: 'shall',
      priorityHint: RequirementPriorityHint.medium,
      moscowPriority: priority,
      stakeholder: 'Unassigned',
      startIndex: 0,
      endIndex: 1,
    );

void main() {
  group('GroupRequirementsByPriority', () {
    test('groups by MoSCoW priority and includes every tier', () {
      final groups = GroupRequirementsByPriority.call(
          [_req(RequirementMoscowPriority.mustHave), _req(RequirementMoscowPriority.mustHave)]);

      expect(groups[RequirementMoscowPriority.mustHave]!.length, 2);
      expect(groups[RequirementMoscowPriority.wontHave], isEmpty);
    });
  });
}
