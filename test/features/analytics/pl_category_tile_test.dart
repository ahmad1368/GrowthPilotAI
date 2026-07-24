import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/core/models/pl_category_breakdown.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_category_tile.dart';

void main() {
  testWidgets('shows the category name and total, but not line items until expanded',
      (tester) async {
    final breakdown = PLCategoryBreakdown(
      categoryName: 'Rent',
      total: 800,
      transactions: [
        TransactionEntity(
            amount: 800, date: DateTime(2026, 1, 5), description: 'January rent'),
      ],
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: PLCategoryTile(breakdown: breakdown)),
    ));

    expect(find.text('Rent'), findsOneWidget);
    expect(find.text('\$800.00'), findsOneWidget);
    expect(find.text('January rent'), findsNothing);

    await tester.tap(find.text('Rent'));
    await tester.pumpAndSettle();

    expect(find.text('January rent'), findsOneWidget);
  });
}
