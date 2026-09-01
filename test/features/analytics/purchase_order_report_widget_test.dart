import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/purchase_order_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/purchase_order_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no purchase orders exist', (tester) async {
    await tester.pumpWidget(_wrap(const PurchaseOrderReportWidget(
        data: {'orders': <PurchaseOrderEntity>[], 'items': <InventoryItemEntity>[]},
        title: 'x')));

    expect(find.text('No purchase orders yet.'), findsOneWidget);
  });

  testWidgets('shows the vendor, summary, and estimated total for a draft order',
      (tester) async {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1));

    await tester.pumpWidget(_wrap(PurchaseOrderReportWidget(
        data: {'orders': [order], 'items': const <InventoryItemEntity>[]}, title: 'x')));

    expect(find.textContaining('Acme Supplies'), findsOneWidget);
    expect(find.textContaining('Flour x16'), findsOneWidget);
    expect(find.text('Mark Sent'), findsOneWidget);
  });

  testWidgets('shows Sent instead of the toggle for a sent order', (tester) async {
    final order = PurchaseOrderEntity(
        vendorName: 'Acme Supplies',
        itemsSummary: 'Flour x16',
        estimatedTotal: 48.0,
        createdAt: DateTime(2026, 1, 1))
      ..status = PurchaseOrderStatus.sent;

    await tester.pumpWidget(_wrap(PurchaseOrderReportWidget(
        data: {'orders': [order], 'items': const <InventoryItemEntity>[]}, title: 'x')));

    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('Mark Sent'), findsNothing);
  });

  testWidgets('shows the "+ Generate PO" button', (tester) async {
    await tester.pumpWidget(_wrap(const PurchaseOrderReportWidget(
        data: {'orders': <PurchaseOrderEntity>[], 'items': <InventoryItemEntity>[]},
        title: 'x')));

    expect(find.text('+ Generate PO'), findsOneWidget);
  });
}
