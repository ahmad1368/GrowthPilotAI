import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_take_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when no stock takes are recorded', (tester) async {
    await tester.pumpWidget(_wrap(const StockTakeReportWidget(
        data: {
          'records': <InventoryStockTakeEntity>[],
          'items': <InventoryItemEntity>[],
        },
        title: 'x')));

    expect(find.text('No stock takes recorded yet.'), findsOneWidget);
  });

  testWidgets('shows the item name, counts, and negative variance for shrinkage',
      (tester) async {
    final record = InventoryStockTakeEntity(
        itemName: 'Flour', systemQuantity: 50, physicalQuantity: 45, takenAt: DateTime(2026, 1, 1));

    await tester.pumpWidget(_wrap(StockTakeReportWidget(
        data: {'records': [record], 'items': const <InventoryItemEntity>[]}, title: 'x')));

    expect(find.text('Flour (50 → 45)'), findsOneWidget);
    expect(find.text('-5'), findsOneWidget);
  });

  testWidgets('shows the "+ Stock Take" quick-add button', (tester) async {
    await tester.pumpWidget(_wrap(const StockTakeReportWidget(
        data: {
          'records': <InventoryStockTakeEntity>[],
          'items': <InventoryItemEntity>[],
        },
        title: 'x')));

    expect(find.text('+ Stock Take'), findsOneWidget);
  });
}
