import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// The "Summary" preview page (Issue #259) — coverage %, mirroring
/// #245's XLSX Summary sheet as a printable page.
class BuildTraceabilitySummaryPdfPage {
  static pw.Widget call(GoalCoverageReport report) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Executive Summary', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text('Overall Coverage: ${(report.overallCoverage * 100).round()}%'),
        pw.Text('Uncovered Goals: ${report.uncoveredGoals.length}'),
        for (final goal in report.uncoveredGoals) pw.Text('- ${goal.title}'),
      ],
    );
  }
}
