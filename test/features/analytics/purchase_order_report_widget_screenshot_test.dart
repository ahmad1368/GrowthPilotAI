import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Automated Purchase Order widget
/// (Issue #443) for QA. Not a golden comparison — it only records the
/// look.
void main() {
  final orders = [
    PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16, Butter x8',
        estimatedTotal: 96.0,
        createdAt: DateTime(2026, 1, 5)),
    PurchaseOrderEntity(
        vendorName: 'Metro Wholesale',
        itemsSummary: 'Sugar x20',
        estimatedTotal: 40.0,
        createdAt: DateTime(2026, 1, 3))
      ..status = PurchaseOrderStatus.sent,
  ];

  Future<void> capture(
      WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark
        ? const Color(0xFF09090B)
        : const Color(0xFFFFFFFF);
    final key = GlobalKey();
    await tester.binding.setSurfaceSize(const Size(380, 320));
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
              child: PurchaseOrderReportWidget(
                  data: {'orders': orders, 'items': const <InventoryItemEntity>[]},
                  title: 'Automated Purchase Orders'),
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

  testWidgets('writes light and dark purchase-order screenshots', (tester) async {
    await capture(tester, Brightness.light, 'purchase_order_light.png');
    await capture(tester, Brightness.dark, 'purchase_order_dark.png');
    expect(File('screenshots/purchase_order_light.png').existsSync(), isTrue);
    expect(File('screenshots/purchase_order_dark.png').existsSync(), isTrue);
  });
}
