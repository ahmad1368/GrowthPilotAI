import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/core/widgets/reorderable_report_list.dart';
import 'package:growth_pilot_ai/features/analytics/report_widgets_bootstrap.dart';

/// Renders the Business Compass's new reorder mode (Issue #114) offscreen
/// and writes light/dark PNGs into `screenshots/`.
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
  const specsById = {
    'RADAR_CHART': ReportWidgetSpec(
        id: 'RADAR_CHART',
        title: 'Success DNA',
        data: {'user': user, 'sector': sector}),
    'INSIGHT_TEXT': ReportWidgetSpec(
        id: 'INSIGHT_TEXT',
        title: 'Strategy Insight',
        data: {
          'narrative': 'Your biggest gap vs. the sector is Vendor Diversity.'
        }),
    'METRIC_LEGEND': ReportWidgetSpec(
        id: 'METRIC_LEGEND', title: 'Axis Breakdown', data: {'user': user}),
  };
  final layout = [
    const WidgetLayout(widgetId: 'RADAR_CHART', position: 0),
    const WidgetLayout(widgetId: 'INSIGHT_TEXT', position: 1),
    const WidgetLayout(widgetId: 'METRIC_LEGEND', position: 2),
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
            child: ReorderableReportList(
                layout: layout, specsById: specsById, onReorder: (_, __) {}),
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

  testWidgets('writes light and dark reorder-mode screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'reorder_mode_light.png');
    await capture(tester, Brightness.dark, 'reorder_mode_dark.png');
    expect(File('screenshots/reorder_mode_light.png').existsSync(), isTrue);
    expect(File('screenshots/reorder_mode_dark.png').existsSync(), isTrue);
  });
}
