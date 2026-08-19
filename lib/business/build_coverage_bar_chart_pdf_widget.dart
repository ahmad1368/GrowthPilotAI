import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Honest client-side stand-in for Issue #252's "Visual Rendering
/// Engine: server-side D3.js/Chart.js charts rendered to PNG/SVG and
/// embedded via Puppeteer" — draws a real vector bar chart directly
/// into the PDF using the `pdf` package's own `pw.Chart`/`pw.BarChart`
/// widgets (no server/headless-browser round trip needed; see PR
/// notes for why this widget is still labeled "preview" upstream).
class BuildCoverageBarChartPdfWidget {
  static pw.Widget call({required int coveredGoals, required int uncoveredGoals}) {
    final total = coveredGoals + uncoveredGoals;
    final maxY = total <= 0 ? 1 : total;
    return pw.SizedBox(
      height: 160,
      child: pw.Chart(
        grid: pw.CartesianGrid(
          xAxis: pw.FixedAxis.fromStrings(['Covered', 'Uncovered']),
          yAxis: pw.FixedAxis<int>([0, maxY]),
        ),
        datasets: [
          pw.BarDataSet(
            color: PdfColors.green300,
            borderColor: PdfColors.green800,
            data: [
              pw.PointChartValue(0, coveredGoals.toDouble()),
              pw.PointChartValue(1, uncoveredGoals.toDouble()),
            ],
          ),
        ],
      ),
    );
  }
}
