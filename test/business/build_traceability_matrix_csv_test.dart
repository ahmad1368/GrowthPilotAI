import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_csv.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

void main() {
  group('BuildTraceabilityMatrixCsv', () {
    test('writes a header row plus one row per requirement', () {
      final goal = BusinessGoalEntity(id: 1, title: 'Reduce wait time');
      final requirement =
          TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'Reduce, response "latency"');
      final link = GoalRequirementLinkEntity()
        ..goal.targetId = 1
        ..requirement.targetId = 100;

      final csv = BuildTraceabilityMatrixCsv.call(
        goals: [goal],
        requirements: [requirement],
        testCases: const [],
        goalLinks: [link],
        testCaseLinks: const [],
        lastModifiedByRequirementId: const {100: 'local-user'},
      );

      final lines = csv.trim().split('\n');
      expect(lines, hasLength(2));
      expect(lines.first, 'Code,Requirement,Dev Status,Business Goals,Test Cases,Last Modified By');
      expect(lines[1], contains('"BR-01"'));
      expect(lines[1], contains('""latency""')); // escaped embedded quote
      expect(lines[1], contains('"Reduce wait time"'));
    });
  });
}
