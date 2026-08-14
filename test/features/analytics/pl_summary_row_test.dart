import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/pl_summary.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_summary_row.dart';

void main() {
  testWidgets('shows formatted income, expense, and net profit amounts',
      (tester) async {
    const summary =
        PLSummary(totalIncome: 1000, totalExpense: 400, expenseByCategory: []);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: PLSummaryRow(summary: summary)),
    ));

    expect(find.text('\$1,000.00'), findsOneWidget);
    expect(find.text('\$400.00'), findsOneWidget);
    expect(find.text('\$600.00'), findsOneWidget); // net profit
  });

  testWidgets('net profit renders in the theme error color when negative',
      (tester) async {
    const summary =
        PLSummary(totalIncome: 100, totalExpense: 300, expenseByCategory: []);
    const errorColor = Colors.red;

    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light(error: errorColor)),
      home: const Scaffold(body: PLSummaryRow(summary: summary)),
    ));

    final netText = tester.widget<Text>(find.text('-\$200.00'));
    expect(netText.style?.color, errorColor);
  });
}
