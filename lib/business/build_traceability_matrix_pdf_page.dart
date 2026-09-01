import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// The "Traceability Matrix" preview page (Issue #259) — same flat
/// rows as #245's XLSX Matrix sheet, rendered as a printable table.
class BuildTraceabilityMatrixPdfPage {
  static pw.Widget call({
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
  }) {
    return pw.TableHelper.fromTextArray(
      headers: ['Code', 'Requirement', 'Dev Status', 'Goals', 'Test Cases'],
      data: [
        for (final requirement in requirements)
          [
            requirement.reqCode,
            requirement.description,
            requirement.devStatus.name,
            goalLinks
                .where((l) => l.requirement.targetId == requirement.id)
                .map((l) => goals.firstWhere((g) => g.id == l.goal.targetId).title)
                .join(', '),
            testCaseLinks
                .where((l) => l.requirement.targetId == requirement.id)
                .map((l) => testCases.firstWhere((t) => t.id == l.testCase.targetId).tcCode)
                .join(', '),
          ],
      ],
    );
  }
}
