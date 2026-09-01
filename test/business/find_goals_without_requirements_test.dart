import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_goals_without_requirements.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';

BusinessGoalEntity _goal(int id) => BusinessGoalEntity(id: id, title: 'goal $id');

GoalRequirementLinkEntity _link(int goalId, int requirementId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = requirementId;

void main() {
  group('FindGoalsWithoutRequirements', () {
    test('flags goals with no requirement link at all', () {
      final result = FindGoalsWithoutRequirements.call([_goal(1), _goal(2)], [_link(1, 100)]);

      expect(result.map((g) => g.id), [2]);
    });

    test('returns nothing when every goal is linked', () {
      final result = FindGoalsWithoutRequirements.call([_goal(1)], [_link(1, 100)]);

      expect(result, isEmpty);
    });
  });
}
