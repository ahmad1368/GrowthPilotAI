import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/widget_config_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_preview_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_config_store.dart';
import 'package:growth_pilot_ai/core/models/report_widget_spec.dart';
import 'package:growth_pilot_ai/core/widgets/widget_config_panel.dart';
import 'package:growth_pilot_ai/features/analytics/report_widgets_bootstrap.dart';

class _InMemoryWidgetConfigStore implements WidgetConfigStore {
  @override
  Future<Map<String, Map<String, bool>>?> load() async => null;
  @override
  Future<void> save(Map<String, Map<String, bool>> values) async {}
}

/// Renders the Business Compass's config side-panel (Issue #115), now
/// backed by the Issue #116 live-preview bridge, offscreen and writes
/// light/dark PNGs into `screenshots/`.
void main() {
  setUp(() {
    ReportWidgetsBootstrap.register();
    ReportWidgetsBootstrap.registerConfig();
    final config = WidgetConfigController(_InMemoryWidgetConfigStore());
    Get.put(config);
    Get.put(WidgetPreviewController(config));
  });

  const specs = [
    ReportWidgetSpec(id: 'RADAR_CHART', title: 'Success DNA', data: {}),
    ReportWidgetSpec(id: 'INSIGHT_TEXT', title: 'Strategy Insight', data: {}),
    ReportWidgetSpec(id: 'METRIC_LEGEND', title: 'Axis Breakdown', data: {}),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final key = GlobalKey();
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    await tester.binding.setSurfaceSize(const Size(320, 600));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness, scaffoldBackgroundColor: bg),
      home: RepaintBoundary(
        key: key,
        child: const Scaffold(body: WidgetConfigPanel(specs: specs)),
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

  testWidgets('writes light and dark config-panel screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'config_panel_light.png');
    await capture(tester, Brightness.dark, 'config_panel_dark.png');
    expect(File('screenshots/config_panel_light.png').existsSync(), isTrue);
    expect(File('screenshots/config_panel_dark.png').existsSync(), isTrue);
  });
}
