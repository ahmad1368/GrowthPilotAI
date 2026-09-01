import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_indirectly_affected_by_requirement.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

GoalRequirementLinkEntity _link(int goalId, int reqId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = reqId;

void main() {
  group('FindIndirectlyAffectedByRequirement', () {
    test('finds sibling requirements sharing a goal', () {
      final requirements = [
        TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'a'),
        TraceableRequirementEntity(id: 200, reqCode: 'BR-02', description: 'b'),
        TraceableRequirementEntity(id: 300, reqCode: 'BR-03', description: 'c'),
      ];
      final links = [_link(1, 100), _link(1, 200), _link(2, 300)];

      final result = FindIndirectlyAffectedByRequirement.call(100, links, requirements);

      expect(result.map((r) => r.id), [200]);
    });

    test('returns nothing when the requirement has no shared goal', () {
      final requirements = [TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'a')];

      final result = FindIndirectlyAffectedByRequirement.call(100, [], requirements);

      expect(result, isEmpty);
    });
  });
}
