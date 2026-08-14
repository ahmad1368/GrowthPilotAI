import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/regional_affordability_report_widget.dart';

TransactionEntity _income(double amount) => TransactionEntity(
    amount: amount, date: DateTime(2026, 1, 1), description: 'sale', dbType: 1);

void main() {
  testWidgets('shows a placeholder when there are no transactions', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: RegionalAffordabilityReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No transactions yet to compare against regional pricing.'), findsOneWidget);
  });

  testWidgets('shows the Overpriced label for a large average basket', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RegionalAffordabilityReportWidget(
            data: {'transactions': [_income(1000)]}, title: 'x'),
      ),
    ));

    expect(find.text('Overpriced'), findsOneWidget);
  });

  testWidgets('shows the Well-aligned label for a moderate average basket', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RegionalAffordabilityReportWidget(
            data: {'transactions': [_income(200)]}, title: 'x'),
      ),
    ));

    expect(find.text('Well-aligned'), findsOneWidget);
  });
}
