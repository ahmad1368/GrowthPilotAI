import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_traceability_report_pdf_document.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/enum/traceability_report_section.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

void main() {
  group('BuildTraceabilityReportPdfDocument', () {
    final goal = BusinessGoalEntity(id: 1, title: 'Reduce wait time');
    final requirement =
        TraceableRequirementEntity(id: 100, reqCode: 'BR-01', description: 'Reduce response latency');
    final coverageReport =
        GoalCoverageReport(overallCoverage: 1, uncoveredGoals: const [], computedAt: DateTime(2026, 1, 1));

    test('produces non-empty PDF bytes with all sections enabled', () async {
      final bytes = await BuildTraceabilityReportPdfDocument.call(
        enabledSections: TraceabilityReportSection.values.toSet(),
        goals: [goal],
        requirements: [requirement],
        testCases: const [],
        goalLinks: const [],
        testCaseLinks: const [],
        coverageReport: coverageReport,
      );

      expect(bytes, isNotEmpty);
    });

    test('does not throw when no sections are enabled', () async {
      final bytes = await BuildTraceabilityReportPdfDocument.call(
        enabledSections: const {},
        goals: [goal],
        requirements: [requirement],
        testCases: const [],
        goalLinks: const [],
        testCaseLinks: const [],
        coverageReport: coverageReport,
      );

      expect(bytes, isNotEmpty);
    });
  });
}
