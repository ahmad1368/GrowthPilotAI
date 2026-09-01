import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_movement_report_widget.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

StockMovementEntity _movement(StockMovementType type, {int quantity = 4}) {
  return StockMovementEntity(
      itemName: 'Flour',
      quantity: quantity,
      resultingQuantityOnHand: 6,
      occurredAt: DateTime(2026, 1, 5))
    ..type = type;
}

void main() {
  testWidgets('shows a placeholder when no stock movements exist', (tester) async {
    await tester.pumpWidget(_wrap(const StockMovementReportWidget(
        data: {
          'movements': <StockMovementEntity>[],
          'items': <InventoryItemEntity>[],
          'reservations': <StockReservationEntity>[],
        },
        title: 'x')));

    expect(find.text('No stock movements recorded yet.'), findsOneWidget);
  });

  testWidgets('shows a Sale badge and decremented quantity for a sale movement', (tester) async {
    await tester.pumpWidget(_wrap(StockMovementReportWidget(
        data: {
          'movements': [_movement(StockMovementType.sale)],
          'items': const <InventoryItemEntity>[],
          'reservations': const <StockReservationEntity>[],
        },
        title: 'x')));

    expect(find.text('Sale'), findsOneWidget);
    expect(find.text('-4  (now 6)'), findsOneWidget);
  });

  testWidgets('shows a Return badge for a return movement', (tester) async {
    await tester.pumpWidget(_wrap(StockMovementReportWidget(
        data: {
          'movements': [_movement(StockMovementType.returnStock)],
          'items': const <InventoryItemEntity>[],
          'reservations': const <StockReservationEntity>[],
        },
        title: 'x')));

    expect(find.text('Return'), findsOneWidget);
    expect(find.text('+4  (now 6)'), findsOneWidget);
  });

  testWidgets('shows the "+ Record Movement" button', (tester) async {
    await tester.pumpWidget(_wrap(const StockMovementReportWidget(
        data: {
          'movements': <StockMovementEntity>[],
          'items': <InventoryItemEntity>[],
          'reservations': <StockReservationEntity>[],
        },
        title: 'x')));

    expect(find.text('+ Record Movement'), findsOneWidget);
  });
}
