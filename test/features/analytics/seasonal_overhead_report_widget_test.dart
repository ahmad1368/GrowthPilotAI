import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_overhead_report_widget.dart';

TransactionEntity _expense(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'out', dbType: 0);

void main() {
  testWidgets('shows the insufficient-history narrative with no expenses',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SeasonalOverheadReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(
        find.text('Not enough expense history yet to spot a seasonal overhead pattern.'),
        findsOneWidget);
  });

  testWidgets('shows the peak-month narrative with enough history', (tester) async {
    final transactions = [
      _expense(DateTime(2026, 1, 1), 100),
      _expense(DateTime(2026, 7, 1), 900),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SeasonalOverheadReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.textContaining('highest-overhead month'), findsOneWidget);
  });
}
