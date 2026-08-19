import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_coverage_bar_chart_pdf_widget.dart';
import 'package:pdf/widgets.dart' as pw;

void main() {
  group('BuildCoverageBarChartPdfWidget', () {
    Future<void> expectRendersWithoutThrowing(int covered, int uncovered) async {
      final doc = pw.Document();
      doc.addPage(pw.Page(
        build: (context) => BuildCoverageBarChartPdfWidget.call(coveredGoals: covered, uncoveredGoals: uncovered),
      ));
      final bytes = await doc.save();
      expect(bytes, isNotEmpty);
    }

    test('renders with a mix of covered and uncovered goals', () async {
      await expectRendersWithoutThrowing(3, 2);
    });

    test('renders when everything is covered (zero uncovered)', () async {
      await expectRendersWithoutThrowing(5, 0);
    });

    test('renders when there are no goals at all (zero/zero)', () async {
      await expectRendersWithoutThrowing(0, 0);
    });
  });
}
