import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/holiday_impact_report_widget.dart';

TransactionEntity _income(DateTime date, double amount) =>
    TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);

void main() {
  testWidgets('shows a placeholder when there is no matching holiday history',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: HolidayImpactReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(
        find.text('Not enough transaction history around statutory holidays yet.'),
        findsOneWidget);
  });

  testWidgets('shows the trending-up icon for a holiday with a positive lift',
      (tester) async {
    final transactions = [
      for (var d = 1; d <= 10; d++) _income(DateTime(2026, 3, d), 10),
      _income(DateTime(2026, 7, 1), 500),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: HolidayImpactReportWidget(data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Canada Day'), findsOneWidget);
    expect(find.byIcon(Icons.trending_up), findsOneWidget);
  });
}
