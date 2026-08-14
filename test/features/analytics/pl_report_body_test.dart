import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pl_report_body.dart';

TransactionEntity _tx(DateTime date, double amount, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

void main() {
  testWidgets(
      'defaults to Monthly, then Quarterly pulls in an older transaction too',
      (tester) async {
    final now = DateTime.now();
    final transactions = [
      _tx(now.subtract(const Duration(days: 10)), 500, income: true), // both windows
      _tx(now.subtract(const Duration(days: 5)), 100, income: false), // both windows
      _tx(now.subtract(const Duration(days: 60)), 300, income: true), // quarterly only
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: PLReportBody(transactions: transactions)),
    ));

    // Monthly: income 500, expense 100, net 400.
    expect(find.text('\$500.00'), findsOneWidget);
    expect(find.text('\$400.00'), findsOneWidget);
    expect(find.text('\$800.00'), findsNothing);

    await tester.tap(find.text('Quarterly'));
    await tester.pump();

    // Quarterly: income 800 (500+300), expense 100, net 700.
    expect(find.text('\$800.00'), findsOneWidget);
    expect(find.text('\$700.00'), findsOneWidget);
  });
}
