import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_batch_export_files.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

void main() {
  group('BuildBatchExportFiles', () {
    test('returns the three numbered files in the issue\'s naming convention', () {
      final goal = BusinessGoalEntity(id: 1, title: 'Reduce wait time');
      final requirement = TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'Reduce latency');
      final coverageReport =
          GoalCoverageReport(overallCoverage: 1, uncoveredGoals: const [], computedAt: DateTime(2026, 1, 1));

      final files = BuildBatchExportFiles.call(
        pdfBytes: Uint8List.fromList(utf8.encode('pdf-content')),
        goals: [goal],
        requirements: [requirement],
        testCases: const [],
        goalLinks: const [],
        testCaseLinks: const [],
        lastModifiedByRequirementId: const {},
        coverageReport: coverageReport,
      );

      expect(files.map((f) => f.filename).toList(),
          ['01_Traceability_Report.pdf', '02_Traceability_Matrix.xlsx', '03_Traceability_Matrix.csv']);
      for (final file in files) {
        expect(file.bytes, isNotEmpty, reason: '${file.filename} must not be empty');
      }
    });
  });
}
