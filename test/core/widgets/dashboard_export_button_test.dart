import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_export_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_export_button.dart';

class _FakePdfService implements DashboardExportService {
  @override
  OmniResult<Uint8List> buildPdf({
    required Uint8List canvasImage,
    required String title,
  }) async =>
      OmniResponse.success(Uint8List.fromList([1]));
}

void main() {
  tearDown(Get.reset);

  testWidgets('shows the export icon and a PDF/PNG menu when idle',
      (tester) async {
    Get.put(DashboardExportController(_FakePdfService()));
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DashboardExportButton(canvasKey: GlobalKey(), title: 'Report'),
      ),
    ));

    expect(find.byIcon(Icons.ios_share), findsOneWidget);

    await tester.tap(find.byIcon(Icons.ios_share));
    await tester.pumpAndSettle();

    expect(find.text('Export as PDF'), findsOneWidget);
    expect(find.text('Export as PNG'), findsOneWidget);
  });

  testWidgets('shows a spinner instead of the icon while exporting',
      (tester) async {
    final controller = Get.put(DashboardExportController(_FakePdfService()));
    controller.isExporting.value = true;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DashboardExportButton(canvasKey: GlobalKey(), title: 'Report'),
      ),
    ));

    expect(find.byIcon(Icons.ios_share), findsNothing);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
