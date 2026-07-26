import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inventory_item_detail_subtitle.dart';

InventoryStockItem _stockItem({
  String? categoryPath,
  String serialNumber = '',
  Map<String, String> attributes = const {},
  String? expiryLabel,
}) =>
    InventoryStockItem(
      name: 'Item',
      quantityOnHand: 10,
      reorderThreshold: 5,
      unitCost: 1,
      status: InventoryStockStatus.ok,
      categoryPath: categoryPath,
      serialNumber: serialNumber,
      attributes: attributes,
      expiryLabel: expiryLabel,
    );

void main() {
  testWidgets('shows custom attributes as key: value pairs', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventoryItemDetailSubtitle(
            item: _stockItem(attributes: const {'Size': 'M', 'Color': 'Red'})),
      ),
    ));

    expect(find.textContaining('Size: M'), findsOneWidget);
    expect(find.textContaining('Color: Red'), findsOneWidget);
  });

  testWidgets('renders nothing extra when there are no details', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: InventoryItemDetailSubtitle(item: _stockItem())),
    ));

    expect(find.byType(Text), findsNothing);
  });

  testWidgets('shows the precomputed expiry label in error color', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InventoryItemDetailSubtitle(item: _stockItem(expiryLabel: 'Expires in 3d')),
      ),
    ));

    expect(find.text('Expires in 3d'), findsOneWidget);
  });
}
