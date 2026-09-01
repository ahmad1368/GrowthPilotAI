import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_goal_coverage_report.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';

GoalRequirementLinkEntity _link(int goalId, int reqId) => GoalRequirementLinkEntity()
  ..goal.targetId = goalId
  ..requirement.targetId = reqId;

void main() {
  group('ComputeGoalCoverageReport', () {
    test('returns 0 coverage for an empty goal list', () {
      final report = ComputeGoalCoverageReport.call(const [], const []);

      expect(report.overallCoverage, 0);
      expect(report.uncoveredGoals, isEmpty);
    });

    test('computes the fraction of goals with at least one linked requirement', () {
      final goals = [
        BusinessGoalEntity(id: 1, title: 'A'),
        BusinessGoalEntity(id: 2, title: 'B'),
        BusinessGoalEntity(id: 3, title: 'C'),
      ];
      final links = [_link(1, 100), _link(2, 200)];

      final report = ComputeGoalCoverageReport.call(goals, links);

      expect(report.overallCoverage, closeTo(2 / 3, 0.001));
      expect(report.uncoveredGoals.map((g) => g.id), [3]);
    });

    test('reports full coverage when every goal has a linked requirement', () {
      final goals = [BusinessGoalEntity(id: 1, title: 'A')];
      final report = ComputeGoalCoverageReport.call(goals, [_link(1, 100)]);

      expect(report.overallCoverage, 1);
      expect(report.uncoveredGoals, isEmpty);
    });
  });
}
