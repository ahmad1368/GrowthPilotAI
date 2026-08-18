import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_requirements_without_goal.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

TraceableRequirementEntity _req(int id) =>
    TraceableRequirementEntity(id: id, reqCode: 'BR-0$id', description: 'req $id');

GoalRequirementLinkEntity _link(int goalId, int requirementId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = requirementId;

void main() {
  group('FindRequirementsWithoutGoal', () {
    test('flags requirements with no goal link at all', () {
      final result = FindRequirementsWithoutGoal.call([_req(1), _req(2)], [_link(10, 1)]);

      expect(result.map((r) => r.id), [2]);
    });

    test('returns nothing when every requirement is linked', () {
      final result = FindRequirementsWithoutGoal.call([_req(1)], [_link(10, 1)]);

      expect(result, isEmpty);
    });
  });
}
