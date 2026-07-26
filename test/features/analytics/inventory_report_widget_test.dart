import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no inventory items are tracked', (tester) async {
    await tester.pumpWidget(_wrap(const InventoryReportWidget(
        data: {
          'items': <InventoryItemEntity>[],
          'categories': <InventoryCategoryEntity>[],
        },
        title: 'x')));

    expect(find.text('No inventory items tracked yet.'), findsOneWidget);
  });

  testWidgets('shows a warning icon for an item at or below its reorder threshold',
      (tester) async {
    final lowStock = InventoryItemEntity(
        name: 'Flour', quantityOnHand: 2, reorderThreshold: 10, unitCost: 3.5);

    await tester.pumpWidget(_wrap(InventoryReportWidget(
        data: {'items': [lowStock], 'categories': const <InventoryCategoryEntity>[]},
        title: 'x')));

    expect(find.text('Flour'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    expect(find.text('2 on hand'), findsOneWidget);
  });

  testWidgets('shows a category path when an item has a category', (tester) async {
    final category = InventoryCategoryEntity(name: 'Bakery');
    final item = InventoryItemEntity(
        name: 'Flour', quantityOnHand: 40, reorderThreshold: 10, unitCost: 3.5);
    item.category.target = category;

    await tester.pumpWidget(_wrap(InventoryReportWidget(
        data: {'items': [item], 'categories': [category]}, title: 'x')));

    expect(find.text('Bakery'), findsOneWidget);
  });

  testWidgets('shows the "+ Add Item" and "+ Category" quick-add buttons', (tester) async {
    await tester.pumpWidget(_wrap(const InventoryReportWidget(
        data: {
          'items': <InventoryItemEntity>[],
          'categories': <InventoryCategoryEntity>[],
        },
        title: 'x')));

    expect(find.text('+ Add Item'), findsOneWidget);
    expect(find.text('+ Category'), findsOneWidget);
  });
}
