import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/compliance_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/compliance_risk_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Legal & Compliance Risk widget
/// (Issue #392) for QA. Not a golden comparison — it only records the look.
void main() {
  final items = [
    ComplianceItemEntity(
        name: 'Health Permit', expiryDate: DateTime.now().subtract(const Duration(days: 5))),
    ComplianceItemEntity(
        name: 'Business License', expiryDate: DateTime.now().add(const Duration(days: 10))),
    ComplianceItemEntity(
        name: 'Zoning Certificate', expiryDate: DateTime.now().add(const Duration(days: 200))),
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
              child: ComplianceRiskReportWidget(
                  data: {'items': items}, title: 'Legal & Compliance Risk'),
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

  testWidgets('writes light and dark compliance-risk screenshots', (tester) async {
    await capture(tester, Brightness.light, 'compliance_risk_light.png');
    await capture(tester, Brightness.dark, 'compliance_risk_dark.png');
    expect(File('screenshots/compliance_risk_light.png').existsSync(), isTrue);
    expect(File('screenshots/compliance_risk_dark.png').existsSync(), isTrue);
  });
}
