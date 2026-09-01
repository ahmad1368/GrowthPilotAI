import 'package:pdf/widgets.dart' as pw;
import 'package:growth_pilot_ai/business/build_coverage_bar_chart_pdf_widget.dart';
import 'package:growth_pilot_ai/core/models/goal_coverage_report.dart';

/// The "Summary" preview page (Issue #259) — coverage %, mirroring
/// #245's XLSX Summary sheet as a printable page. [totalGoals] drives
/// the covered/uncovered bar chart (Issue #252's honest client-side
/// stand-in for the "headless chart" embedded via Puppeteer).
class BuildTraceabilitySummaryPdfPage {
  static pw.Widget call(GoalCoverageReport report, {required int totalGoals}) {
    final uncovered = report.uncoveredGoals.length;
    final covered = (totalGoals - uncovered) < 0 ? 0 : totalGoals - uncovered;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('Executive Summary', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 8),
        pw.Text('Overall Coverage: ${(report.overallCoverage * 100).round()}%'),
        pw.Text('Uncovered Goals: $uncovered'),
        pw.SizedBox(height: 12),
        BuildCoverageBarChartPdfWidget.call(coveredGoals: covered, uncoveredGoals: uncovered),
        pw.SizedBox(height: 12),
        for (final goal in report.uncoveredGoals) pw.Text('- ${goal.title}'),
      ],
    );
  }
}
