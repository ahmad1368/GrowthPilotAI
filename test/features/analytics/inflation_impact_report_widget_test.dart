import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/inflation_impact_report_widget.dart';

TransactionEntity _tx(double amount, {required bool income}) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);

void main() {
  testWidgets('shows a placeholder when there is no transaction data',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InflationImpactReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('Not enough transaction data to simulate yet.'),
        findsOneWidget);
  });

  testWidgets('shows all 3 scenario labels and the reference rate caption',
      (tester) async {
    final transactions = [
      _tx(1000, income: true),
      _tx(500, income: false),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InflationImpactReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Current'), findsOneWidget);
    expect(find.text('Absorb Cost Increase'), findsOneWidget);
    expect(find.text('Pass Through to Prices'), findsOneWidget);
    expect(
        find.textContaining('static illustrative figure, not a live index'),
        findsOneWidget);
  });
}
