import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/business/build_traceability_report_pdf_document.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/traceability_link_repository.dart';
import 'package:growth_pilot_ai/core/enum/traceability_report_section.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Real-Time Document Preview" (Issue #259), mixed into
/// `TraceabilityController` — must come after `TraceabilityCoverageMixin`
/// in the `with` clause so [coverageReport] is already available.
mixin TraceabilityReportPreviewMixin on GetxController {
  RxList<BusinessGoalEntity> get goalList;
  RxList<TraceableRequirementEntity> get requirementList;
  RxList<TraceabilityTestCaseEntity> get testCaseList;
  TraceabilityLinkRepository get linkRepository;
  Rxn<GoalCoverageReport> get coverageReport;

  final enabledReportSections = {
    TraceabilityReportSection.summary,
    TraceabilityReportSection.matrix,
    TraceabilityReportSection.requirements,
  }.obs;

  void toggleReportSection(TraceabilityReportSection section) {
    if (!enabledReportSections.remove(section)) enabledReportSections.add(section);
  }

  Future<Uint8List> buildReportPdfBytes() {
    return BuildTraceabilityReportPdfDocument.call(
      enabledSections: enabledReportSections,
      goals: goalList,
      requirements: requirementList,
      testCases: testCaseList,
      goalLinks: linkRepository.goalLinksFor(),
      testCaseLinks: linkRepository.allTestCaseLinks(),
      coverageReport: coverageReport.value ??
          GoalCoverageReport(overallCoverage: 0, uncoveredGoals: const [], computedAt: DateTime.now()),
    );
  }
}
