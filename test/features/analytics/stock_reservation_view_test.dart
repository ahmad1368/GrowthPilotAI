import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/stock_reservation_view.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

Widget _wrap(Widget child) => MaterialApp(
      home: ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: Scaffold(body: child),
      ),
    );

void main() {
  testWidgets('shows a placeholder when there are no active locks', (tester) async {
    await tester.pumpWidget(_wrap(StockReservationView(
        reservations: const [],
        onReserve: () {},
        onConfirm: (_) {},
        onRelease: (_) {})));

    expect(find.text('No active online-checkout locks.'), findsOneWidget);
  });

  testWidgets('lists an active reservation and confirms it on tap', (tester) async {
    final reservation = StockReservationEntity(
        itemId: 1, itemName: 'Flour', quantityReserved: 3, createdAt: DateTime(2026, 1, 6));
    StockReservationEntity? confirmed;

    await tester.pumpWidget(_wrap(StockReservationView(
        reservations: [reservation],
        onReserve: () {},
        onConfirm: (r) => confirmed = r,
        onRelease: (_) {})));

    expect(find.text('Flour  × 3'), findsOneWidget);

    await tester.tap(find.text('Confirm'));
    expect(confirmed, reservation);
  });

  testWidgets('reserve button invokes the callback', (tester) async {
    var tapped = false;
    await tester.pumpWidget(_wrap(StockReservationView(
        reservations: const [],
        onReserve: () => tapped = true,
        onConfirm: (_) {},
        onRelease: (_) {})));

    await tester.tap(find.text('+ Reserve Online'));
    expect(tapped, isTrue);
  });
}
