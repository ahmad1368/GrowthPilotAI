import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

/// Captures light/dark PNGs of the new Goods Receipt & Invoice Matching
/// widget (Issue #444) for QA. Not a golden comparison — it only records
/// the look.
void main() {
  final order = PurchaseOrderEntity(
      vendorName: 'Acme Supplies',
      itemsSummary: 'Flour x16',
      estimatedTotal: 48.0,
      createdAt: DateTime(2026, 1, 1));
  final unmatchedOrder = PurchaseOrderEntity(
      vendorName: 'Metro Wholesale',
      itemsSummary: 'Sugar x20',
      estimatedTotal: 40.0,
      createdAt: DateTime(2026, 1, 3));

  final matched = GoodsReceiptEntity(
    receivedItemsSummary: 'Flour x16',
    invoiceReference: 'INV-1001',
    invoiceAmount: 48.0,
    receivedAt: DateTime(2026, 1, 5),
  )..purchaseOrder.target = order;

  final discrepancy = GoodsReceiptEntity(
    receivedItemsSummary: 'Sugar x20',
    damagedOrMissingNotes: '2 bags torn in transit',
    invoiceReference: 'INV-1002',
    invoiceAmount: 46.0,
    receivedAt: DateTime(2026, 1, 3),
  )..purchaseOrder.target = unmatchedOrder;

  final noPoLinked = GoodsReceiptEntity(
    receivedItemsSummary: 'Butter x8',
    invoiceReference: 'INV-1003',
    invoiceAmount: 24.0,
    receivedAt: DateTime(2026, 1, 1),
  );

  final receipts = [matched, discrepancy, noPoLinked];

  Future<void> capture(WidgetTester tester, Brightness brightness, String file) async {
    final bg = brightness == Brightness.dark ? const Color(0xFF09090B) : const Color(0xFFFFFFFF);
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
              child: GoodsReceiptReportWidget(
                  data: {'receipts': receipts, 'orders': [order, unmatchedOrder]},
                  title: 'Goods Receipt & Invoice Matching'),
            ),
          ),
        ),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.runAsync(() async {
      final boundary = key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 2);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      Directory('screenshots').createSync(recursive: true);
      File('screenshots/$file').writeAsBytesSync(bytes!.buffer.asUint8List());
    });
  }

  testWidgets('writes light and dark goods-receipt screenshots', (tester) async {
    await capture(tester, Brightness.light, 'goods_receipt_light.png');
    await capture(tester, Brightness.dark, 'goods_receipt_dark.png');
    expect(File('screenshots/goods_receipt_light.png').existsSync(), isTrue);
    expect(File('screenshots/goods_receipt_dark.png').existsSync(), isTrue);
  });
}
