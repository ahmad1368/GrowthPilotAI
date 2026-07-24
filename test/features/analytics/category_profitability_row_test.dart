import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/category_profitability.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_row.dart';

void main() {
  testWidgets('shows the category name and formatted net profit',
      (tester) async {
    const item =
        CategoryProfitability(categoryName: 'Consulting', income: 1000, expense: 300);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: CategoryProfitabilityRow(item: item, maxAbs: 700)),
    ));

    expect(find.text('Consulting'), findsOneWidget);
    expect(find.text('\$700.00'), findsOneWidget);
  });

  testWidgets('a loss-making category renders its amount in the theme error color',
      (tester) async {
    const item =
        CategoryProfitability(categoryName: 'Overhead', income: 0, expense: 500);
    const errorColor = Colors.red;

    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light(error: errorColor)),
      home: const Scaffold(
          body: CategoryProfitabilityRow(item: item, maxAbs: 500)),
    ));

    final amountText = tester.widget<Text>(find.text('-\$500.00'));
    expect(amountText.style?.color, errorColor);
  });
}
