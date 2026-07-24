import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_export_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_export_service.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_export_button.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class _FakePdfService implements DashboardExportService {
  @override
  OmniResult<Uint8List> buildPdf({
    required Uint8List canvasImage,
    required String title,
  }) async =>
      OmniResponse.success(Uint8List.fromList([1]));
}

/// Captures light/dark PNGs of the new Business Compass AppBar export icon
/// (Issue #117) for QA. Not a golden comparison — it only records the look.
void main() {
  tearDown(Get.reset);

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    Get.put(DashboardExportController(_FakePdfService()));
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(120, 60));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: Center(
            child: RepaintBoundary(
              key: key,
              child: Container(
                color: bg,
                child: DashboardExportButton(canvasKey: GlobalKey(), title: 'Report'),
              ),
            ),
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

  testWidgets('writes light and dark export-button screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'export_button_light.png');
    await capture(tester, Brightness.dark, 'export_button_dark.png');
    expect(File('screenshots/export_button_light.png').existsSync(), isTrue);
    expect(File('screenshots/export_button_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
