import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
        data: {'items': <InventoryItemEntity>[]}, title: 'x')));

    expect(find.text('No inventory items tracked yet.'), findsOneWidget);
  });

  testWidgets('shows a warning icon for an item at or below its reorder threshold',
      (tester) async {
    final lowStock = InventoryItemEntity(
        name: 'Flour', quantityOnHand: 2, reorderThreshold: 10, unitCost: 3.5);

    await tester.pumpWidget(_wrap(InventoryReportWidget(
        data: {'items': [lowStock]}, title: 'x')));

    expect(find.text('Flour'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
    expect(find.text('2 on hand'), findsOneWidget);
  });

  testWidgets('shows the "+ Add Item" quick-add button', (tester) async {
    await tester.pumpWidget(_wrap(const InventoryReportWidget(
        data: {'items': <InventoryItemEntity>[]}, title: 'x')));

    expect(find.text('+ Add Item'), findsOneWidget);
  });
}
