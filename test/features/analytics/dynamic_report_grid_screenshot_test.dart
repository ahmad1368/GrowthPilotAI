import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/dynamic_report_grid.dart';
import 'package:growth_pilot_ai/features/analytics/report_widgets_bootstrap.dart';

/// Renders the Business Compass (Issue #84) through the new masonry canvas
/// (Issue #113) offscreen and writes light/dark PNGs into `screenshots/` —
/// the radar chart spans the full row, with the insight text and metric
/// legend sharing a row two-up.
void main() {
  ReportWidgetsBootstrap.register();

  const user = BusinessCompassMetrics(
    liquidityRatio: 0.7,
    burnVelocity: 0.4,
    vendorDiversity: 0.2,
    paymentPunctuality: 0.85,
    profitMargin: 0.5,
  );
  const sector = BusinessCompassMetrics(
    liquidityRatio: 0.8,
    burnVelocity: 0.45,
    vendorDiversity: 0.9,
    paymentPunctuality: 0.9,
    profitMargin: 0.55,
  );
  const specs = [
    ReportWidgetSpec(
        id: 'RADAR_CHART',
        title: 'Success DNA',
        data: {'user': user, 'sector': sector}),
    ReportWidgetSpec(
        id: 'INSIGHT_TEXT',
        title: 'Strategy Insight',
        data: {
          'narrative': 'Your biggest gap vs. the sector is Vendor Diversity.'
        }),
    ReportWidgetSpec(
        id: 'METRIC_LEGEND', title: 'Axis Breakdown', data: {'user': user}),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final key = GlobalKey();
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    await tester.binding.setSurfaceSize(const Size(390, 1000));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: Scaffold(
        body: RepaintBoundary(
          key: key,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(12),
            child:
                const SingleChildScrollView(child: DynamicReportGrid(specs: specs)),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      Directory('screenshots').createSync(recursive: true);
      File('screenshots/$file').writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  testWidgets('writes light and dark report-grid screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'report_grid_light.png');
    await capture(tester, Brightness.dark, 'report_grid_dark.png');
    expect(File('screenshots/report_grid_light.png').existsSync(), isTrue);
    expect(File('screenshots/report_grid_dark.png').existsSync(), isTrue);
  });
}
