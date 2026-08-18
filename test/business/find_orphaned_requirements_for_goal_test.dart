import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_orphaned_requirements_for_goal.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';

GoalRequirementLinkEntity _link(int goalId, int requirementId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = requirementId;

void main() {
  group('FindOrphanedRequirementsForGoal', () {
    test('flags a requirement only linked to the goal being deleted', () {
      final orphaned = FindOrphanedRequirementsForGoal.call([_link(1, 100)], 1);

      expect(orphaned, [100]);
    });

    test('does not flag a requirement linked to another goal too', () {
      final orphaned = FindOrphanedRequirementsForGoal.call([_link(1, 100), _link(2, 100)], 1);

      expect(orphaned, isEmpty);
    });

    test('ignores links to other goals entirely', () {
      final orphaned = FindOrphanedRequirementsForGoal.call([_link(2, 200)], 1);

      expect(orphaned, isEmpty);
    });
  });
}
