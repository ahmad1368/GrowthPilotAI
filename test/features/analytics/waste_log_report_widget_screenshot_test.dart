import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/waste_log_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/waste_log_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

WasteLogEntity _entry(double value, WasteReason reason) => WasteLogEntity(
    itemDescription: 'item', estimatedValue: value, date: DateTime(2026, 1, 1))
  ..reason = reason;

/// Captures light/dark PNGs of the new Food Waste & Spoilage widget (Issue
/// #377) for QA. Not a golden comparison — it only records the look.
void main() {
  final entries = [
    _entry(45, WasteReason.expiration),
    _entry(20, WasteReason.damage),
    _entry(10, WasteReason.overPreparation),
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 420));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(brightness),
        child: Scaffold(
          body: RepaintBoundary(
            key: key,
            child: Container(
              color: bg,
              padding: const EdgeInsets.all(12),
              child: WasteLogReportWidget(
                  data: {'wasteEntries': entries}, title: 'Food Waste & Spoilage'),
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

  testWidgets('writes light and dark waste-log screenshots', (tester) async {
    await capture(tester, Brightness.light, 'waste_log_light.png');
    await capture(tester, Brightness.dark, 'waste_log_dark.png');
    expect(File('screenshots/waste_log_light.png').existsSync(), isTrue);
    expect(File('screenshots/waste_log_dark.png').existsSync(), isTrue);
  });
}
