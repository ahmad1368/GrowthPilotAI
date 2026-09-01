import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/kpi_dashboard_export_controller.dart';

void main() {
  // Sharing itself needs a native platform channel flutter_test doesn't
  // provide (same as #117's DashboardExportController tests), so this
  // asserts what the controller can promise without one: capture ran
  // without crashing, and isExporting always ends false.
  testWidgets('exportPng captures the boundary and resets isExporting', (tester) async {
    final controller = KpiDashboardExportController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(
            key: controller.captureKey, child: const SizedBox(width: 10, height: 10)),
      ),
    ));

    await tester.runAsync(() => controller.exportPng());

    expect(controller.isExporting.value, false);
  });

  testWidgets('a second export call while one is running is a no-op', (tester) async {
    final controller = KpiDashboardExportController();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(
            key: controller.captureKey, child: const SizedBox(width: 10, height: 10)),
      ),
    ));

    await tester.runAsync(() async {
      final first = controller.exportPng();
      expect(controller.isExporting.value, true);

      await controller.exportPng(); // guarded no-op
      await first;
    });

    expect(controller.isExporting.value, false);
  });
}
