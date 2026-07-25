import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/cash_flow_forecast_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

void main() {
  testWidgets('shows a placeholder when there is no transaction history',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CashFlowForecastReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('Not enough transaction history to forecast yet.'),
        findsOneWidget);
  });

  testWidgets('shows the 3 projected month labels', (tester) async {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 10), income: true),
      _tx(300, DateTime(2026, 1, 10), income: false),
      _tx(1000, DateTime(2026, 2, 10), income: true),
      _tx(300, DateTime(2026, 2, 10), income: false),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CashFlowForecastReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Mar 2026'), findsOneWidget);
    expect(find.text('Apr 2026'), findsOneWidget);
    expect(find.text('May 2026'), findsOneWidget);
    expect(find.text('Next 3 Months'), findsOneWidget);
  });

  testWidgets('shows a liquidity-warning banner when a month is a deficit',
      (tester) async {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 5), income: true),
      _tx(100, DateTime(2026, 1, 5), income: false),
      _tx(500, DateTime(2026, 2, 5), income: true),
      _tx(900, DateTime(2026, 2, 5), income: false),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CashFlowForecastReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(
        find.text('Projected cash shortfall ahead — review upcoming expenses'),
        findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsWidgets);
  });
}
