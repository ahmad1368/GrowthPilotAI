import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "CSV vs. XLSX: always provide CSV as an option for raw data imports
/// into other BI tools" (Issue #247) — same flat rows as #245's
/// "Matrix" XLSX sheet, rendered as CSV instead, same escaping
/// convention as this repo's #213 `BuildErrorLogCsv`.
class BuildTraceabilityMatrixCsv {
  static String call({
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
    required Map<int, String> lastModifiedByRequirementId,
  }) {
    final buffer = StringBuffer('Code,Requirement,Dev Status,Business Goals,Test Cases,Last Modified By\n');
    for (final requirement in requirements) {
      final goalTitles = goalLinks
          .where((l) => l.requirement.targetId == requirement.id)
          .map((l) => goals.firstWhere((g) => g.id == l.goal.targetId).title)
          .join('; ');
      final tcCodes = testCaseLinks
          .where((l) => l.requirement.targetId == requirement.id)
          .map((l) => testCases.firstWhere((t) => t.id == l.testCase.targetId).tcCode)
          .join('; ');
      final lastModifiedBy = lastModifiedByRequirementId[requirement.id] ?? 'local-user';

      buffer.writeln([
        requirement.reqCode,
        requirement.description,
        requirement.devStatus.name,
        goalTitles,
        tcCodes,
        lastModifiedBy,
      ].map(_escape).join(','));
    }
    return buffer.toString();
  }

  static String _escape(String value) => '"${value.replaceAll('"', '""')}"';
}
