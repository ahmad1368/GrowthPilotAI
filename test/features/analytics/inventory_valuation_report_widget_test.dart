import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_valuation_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder and zero total with no items', (tester) async {
    await tester.pumpWidget(_wrap(const InventoryValuationReportWidget(
        data: {'items': <InventoryItemEntity>[], 'layers': <InventoryCostLayerEntity>[]},
        title: 'x')));

    expect(find.text('No inventory items yet.'), findsOneWidget);
    expect(find.text('Total value: \$0.00'), findsOneWidget);
  });

  testWidgets('shows a computed row and total for an item with cost layers', (tester) async {
    final item = InventoryItemEntity(
        id: 1, name: 'Flour', quantityOnHand: 5, reorderThreshold: 1, unitCost: 2);
    final layer = InventoryCostLayerEntity(
        itemId: 1, itemName: 'Flour', quantity: 5, unitCost: 2, receivedAt: DateTime(2026, 1, 1));

    await tester.pumpWidget(_wrap(InventoryValuationReportWidget(
        data: {'items': [item], 'layers': [layer]}, title: 'x')));

    expect(find.text('Flour'), findsOneWidget);
    expect(find.text('Total value: \$10.00'), findsOneWidget);
  });

  testWidgets('shows the "+ Record Cost Layer" button', (tester) async {
    await tester.pumpWidget(_wrap(const InventoryValuationReportWidget(
        data: {'items': <InventoryItemEntity>[], 'layers': <InventoryCostLayerEntity>[]},
        title: 'x')));

    expect(find.text('+ Record Cost Layer'), findsOneWidget);
  });
}
