import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/goods_receipt_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

GoodsReceiptEntity _receipt({
  PurchaseOrderEntity? order,
  String damagedOrMissingNotes = '',
  required double invoiceAmount,
}) {
  final receipt = GoodsReceiptEntity(
    receivedItemsSummary: 'Flour x16',
    damagedOrMissingNotes: damagedOrMissingNotes,
    invoiceReference: 'INV-1',
    invoiceAmount: invoiceAmount,
    receivedAt: DateTime(2026, 1, 5),
  );
  if (order != null) receipt.purchaseOrder.target = order;
  return receipt;
}

void main() {
  testWidgets('shows a placeholder when no goods receipts exist', (tester) async {
    await tester.pumpWidget(_wrap(const GoodsReceiptReportWidget(
        data: {'receipts': <GoodsReceiptEntity>[], 'orders': <PurchaseOrderEntity>[]},
        title: 'x')));

    expect(find.text('No goods receipts recorded yet.'), findsOneWidget);
  });

  testWidgets('shows a Matched badge when the invoice matches the order total', (tester) async {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1));

    await tester.pumpWidget(_wrap(GoodsReceiptReportWidget(
        data: {
          'receipts': [_receipt(order: order, invoiceAmount: 48.0)],
          'orders': [order],
        },
        title: 'x')));

    expect(find.text('Matched'), findsOneWidget);
    expect(find.textContaining('Acme Supplies'), findsOneWidget);
  });

  testWidgets('shows a Discrepancy badge when the invoice differs from the order total',
      (tester) async {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1));

    await tester.pumpWidget(_wrap(GoodsReceiptReportWidget(
        data: {
          'receipts': [_receipt(order: order, invoiceAmount: 60.0)],
          'orders': [order],
        },
        title: 'x')));

    expect(find.text('Discrepancy'), findsOneWidget);
  });

  testWidgets('shows a "No PO linked" badge when the receipt has no linked order',
      (tester) async {
    await tester.pumpWidget(_wrap(GoodsReceiptReportWidget(
        data: {
          'receipts': [_receipt(invoiceAmount: 48.0)],
          'orders': const <PurchaseOrderEntity>[],
        },
        title: 'x')));

    expect(find.text('No PO linked'), findsOneWidget);
  });

  testWidgets('shows a Damaged/Missing badge when notes are present', (tester) async {
    await tester.pumpWidget(_wrap(GoodsReceiptReportWidget(
        data: {
          'receipts': [_receipt(invoiceAmount: 48.0, damagedOrMissingNotes: '2 bags torn')],
          'orders': const <PurchaseOrderEntity>[],
        },
        title: 'x')));

    expect(find.text('Damaged/Missing'), findsOneWidget);
  });

  testWidgets('shows the "+ Record Receipt" button', (tester) async {
    await tester.pumpWidget(_wrap(const GoodsReceiptReportWidget(
        data: {'receipts': <GoodsReceiptEntity>[], 'orders': <PurchaseOrderEntity>[]},
        title: 'x')));

    expect(find.text('+ Record Receipt'), findsOneWidget);
  });
}
