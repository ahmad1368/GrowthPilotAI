import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_directly_affected_by_requirement.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';

GoalRequirementLinkEntity _goalLink(int goalId, int reqId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = reqId;

RequirementTestCaseLinkEntity _tcLink(int reqId, int tcId) => RequirementTestCaseLinkEntity()
  ..requirement.targetId = reqId
  ..testCase.targetId = tcId;

void main() {
  group('FindDirectlyAffectedByRequirement', () {
    test('goals returns only goals linked to the given requirement', () {
      final goals = [BusinessGoalEntity(id: 1, title: 'A'), BusinessGoalEntity(id: 2, title: 'B')];
      final result = FindDirectlyAffectedByRequirement.goals(100, [_goalLink(1, 100)], goals);

      expect(result.map((g) => g.id), [1]);
    });

    test('testCases returns only test cases linked to the given requirement', () {
      final testCases = [TraceabilityTestCaseEntity(id: 1, tcCode: 'TC-01', title: 'A')];
      final result = FindDirectlyAffectedByRequirement.testCases(100, [_tcLink(100, 1)], testCases);

      expect(result.map((t) => t.id), [1]);
    });
  });
}
