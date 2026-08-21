import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/business/build_pdf_branding_header_widget.dart';
import 'package:growth_pilot_ai/business/build_signature_placeholder_pdf_widget.dart';
import 'package:growth_pilot_ai/business/build_traceability_matrix_pdf_page.dart';
import 'package:growth_pilot_ai/business/build_traceability_requirements_pdf_page.dart';
import 'package:growth_pilot_ai/business/build_traceability_summary_pdf_page.dart';
import 'package:growth_pilot_ai/core/data/entities/branding_settings_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/requirement_test_case_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceability_test_case_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/enum/traceability_report_section.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// "Live preview of the formatted report... before finalizing the
/// export" (Issue #259) — a real, working `pw.Document` (this repo's
/// `pdf`/`printing` packages, already used by #117's dashboard export)
/// previewed via `printing`'s `PdfPreview` widget, not the issue's
/// server-rendered Puppeteer stream (no backend exists in this repo;
/// see PR notes). Every included page carries a "DRAFT" watermark and,
/// when [branding] is set, Issue #257's logo/company-name/brand-color
/// header via [BuildPdfBrandingHeaderWidget].
class BuildTraceabilityReportPdfDocument {
  static Future<Uint8List> call({
    required Set<TraceabilityReportSection> enabledSections,
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<TraceabilityTestCaseEntity> testCases,
    required List<GoalRequirementLinkEntity> goalLinks,
    required List<RequirementTestCaseLinkEntity> testCaseLinks,
    required GoalCoverageReport coverageReport,
    BrandingSettingsEntity? branding,
  }) async {
    final doc = pw.Document();
    final header = BuildPdfBrandingHeaderWidget.call(branding);
    final content = <pw.Widget>[
      if (enabledSections.contains(TraceabilityReportSection.summary))
        BuildTraceabilitySummaryPdfPage.call(coverageReport, totalGoals: goals.length),
      if (enabledSections.contains(TraceabilityReportSection.matrix))
        BuildTraceabilityMatrixPdfPage.call(
          goals: goals,
          requirements: requirements,
          testCases: testCases,
          goalLinks: goalLinks,
          testCaseLinks: testCaseLinks,
        ),
      if (enabledSections.contains(TraceabilityReportSection.requirements))
        BuildTraceabilityRequirementsPdfPage.call(requirements),
    ];
    if (content.isEmpty) content.add(pw.Text('No sections selected.'));

    for (var i = 0; i < content.length; i++) {
      final isLast = i == content.length - 1;
      doc.addPage(pw.Page(
        build: (context) => pw.Stack(children: [
          pw.Watermark.text('DRAFT'),
          pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
            header,
            content[i],
            if (isLast) BuildSignaturePlaceholderPdfWidget.call(),
          ]),
        ]),
      ));
    }
    return doc.save();
  }
}
