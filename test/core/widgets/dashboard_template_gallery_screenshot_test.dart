import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/dashboard_template_controller.dart';
import 'package:growth_pilot_ai/controllers/widget_layout_controller.dart';
import 'package:growth_pilot_ai/core/interfaces/dashboard_template_store.dart';
import 'package:growth_pilot_ai/core/interfaces/widget_layout_store.dart';
import 'package:growth_pilot_ai/core/models/widget_layout.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/core/widgets/dashboard_template_gallery.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class _NullLayoutStore implements WidgetLayoutStore {
  @override
  Future<List<WidgetLayout>?> load() async => null;
  @override
  Future<void> save(List<WidgetLayout> layout) async {}
}

class _NullTemplateStore implements DashboardTemplateStore {
  @override
  Future<void> backupLayout(List<WidgetLayout> layout) async {}
  @override
  Future<List<WidgetLayout>?> loadBackup() async => null;
}

/// Captures light/dark PNGs of the new "Template Store" gallery (Issue
/// #118) for QA. Not a golden comparison — it only records the look.
void main() {
  tearDown(Get.reset);

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final layoutController = Get.put(WidgetLayoutController(_NullLayoutStore()));
    Get.put(DashboardTemplateController(layoutController, _NullTemplateStore()));
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(400, 170));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          backgroundColor: bg,
          body: RepaintBoundary(
            key: key,
            child: Container(color: bg, child: const DashboardTemplateGallery()),
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

  testWidgets('writes light and dark template-gallery screenshots',
      (tester) async {
    await capture(tester, Brightness.light, 'template_gallery_light.png');
    await capture(tester, Brightness.dark, 'template_gallery_dark.png');
    expect(File('screenshots/template_gallery_light.png').existsSync(), isTrue);
    expect(File('screenshots/template_gallery_dark.png').existsSync(), isTrue);
    await tester.binding.setSurfaceSize(null);
  });
}
