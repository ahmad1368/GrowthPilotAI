import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/annual_profit_forecast_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {required bool income}) =>
    TransactionEntity(
        amount: amount, date: date, description: 'x', dbType: income ? 1 : 0);

void main() {
  testWidgets('shows a placeholder when there is no transaction history', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: AnnualProfitForecastReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('Not enough transaction history to forecast yet.'), findsOneWidget);
  });

  testWidgets('shows the Best Case, Expected, and Worst Case rows plus the peak-month narrative',
      (tester) async {
    final transactions = [
      _tx(1000, DateTime(2026, 1, 10), income: true),
      _tx(300, DateTime(2026, 1, 10), income: false),
      _tx(1000, DateTime(2026, 2, 10), income: true),
      _tx(300, DateTime(2026, 2, 10), income: false),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: AnnualProfitForecastReportWidget(data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Best Case'), findsOneWidget);
    expect(find.text('Expected'), findsOneWidget);
    expect(find.text('Worst Case'), findsOneWidget);
    expect(find.text('Projected to peak in Mar 2026.'), findsOneWidget);
  });
}
