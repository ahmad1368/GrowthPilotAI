import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/export_traceability_matrix_to_xlsx.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

void main() {
  group('ExportTraceabilityMatrixToXlsx', () {
    test('produces a workbook with a Matrix sheet and a Summary sheet', () {
      final goal = BusinessGoalEntity(id: 1, title: 'Reduce wait time');
      final requirement =
          TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'Reduce response latency');
      final link = GoalRequirementLinkEntity()
        ..goal.targetId = 1
        ..requirement.targetId = 100;

      final bytes = ExportTraceabilityMatrixToXlsx.call(
        goals: [goal],
        requirements: [requirement],
        testCases: const [],
        goalLinks: [link],
        testCaseLinks: const [],
        lastModifiedByRequirementId: const {100: 'local-user'},
        coverageReport: GoalCoverageReport(
            overallCoverage: 1, uncoveredGoals: const [], computedAt: DateTime(2026, 1, 1)),
      );

      final decoded = Excel.decodeBytes(bytes);

      expect(decoded.tables.keys, containsAll(['Matrix', 'Summary', 'Grid', 'Requirements']));
      expect(decoded.tables.keys, isNot(contains('Sheet1')));
      final matrixRows = decoded.tables['Matrix']!.rows;
      expect(matrixRows.length, 2); // header + one requirement
      expect(matrixRows[0][0]?.value.toString(), 'Code');
      expect(matrixRows[1][0]?.value.toString(), 'BR-01');

      final gridRows = decoded.tables['Grid']!.rows;
      expect(gridRows[0][1]?.value.toString(), 'Reduce wait time');
      expect(gridRows[1][1]?.value.toString(), 'X'); // linked intersection

      final reqRows = decoded.tables['Requirements']!.rows;
      expect(reqRows[1][0]?.value.toString(), 'BR-01');
    });
  });
}
