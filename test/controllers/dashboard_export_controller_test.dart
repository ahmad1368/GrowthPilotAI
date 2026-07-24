import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/controllers/dashboard_export_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

class _FakePdfService implements DashboardExportService {
  int calls = 0;
  @override
  OmniResult<Uint8List> buildPdf({
    required Uint8List canvasImage,
    required String title,
  }) async {
    calls++;
    return OmniResponse.success(Uint8List.fromList([1, 2, 3]));
  }
}

void main() {
  // Sharing itself needs a native platform channel flutter_test doesn't
  // provide (Issue #117's Printing/share_plus calls), so these assert what
  // the controller can promise without one: capture+build ran, and
  // isExporting always ends false, whatever the share step does.
  testWidgets('exportPdf calls the export service and resets isExporting',
      (tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(key: key, child: const SizedBox(width: 10, height: 10)),
      ),
    ));
    final service = _FakePdfService();
    final controller = DashboardExportController(service);

    // toImage()'s GPU rasterization needs a real async gap, which the fake
    // test zone otherwise deadlocks on — same as the #115 screenshot tests.
    await tester.runAsync(() => controller.exportPdf(key, 'Business Compass'));

    expect(service.calls, 1);
    expect(controller.isExporting.value, false);
  });

  testWidgets('a second export call while one is running is a no-op',
      (tester) async {
    final key = GlobalKey();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepaintBoundary(key: key, child: const SizedBox(width: 10, height: 10)),
      ),
    ));
    final service = _FakePdfService();
    final controller = DashboardExportController(service);

    await tester.runAsync(() async {
      // exportPdf runs synchronously up to its first await, so isExporting
      // is already true here without needing to await `first`.
      final first = controller.exportPdf(key, 'Business Compass');
      expect(controller.isExporting.value, true);

      await controller.exportPdf(key, 'Business Compass'); // guarded no-op
      await first;
    });

    expect(service.calls, 1);
    expect(controller.isExporting.value, false);
  });
}
