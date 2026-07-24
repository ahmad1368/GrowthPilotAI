import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_profitability_report_widget.dart';

TransactionEntity _tx(double amount, {required bool income, CategoryEntity? category}) {
  final tx = TransactionEntity(
      amount: amount, date: DateTime(2026, 1, 1), description: 'x', dbType: income ? 1 : 0);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  testWidgets('shows a placeholder when there are no transactions',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CategoryProfitabilityReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No categorized transactions yet.'), findsOneWidget);
  });

  testWidgets('lists categories with the top revenue driver first',
      (tester) async {
    final gold = CategoryEntity(name: 'Gold Tier');
    final bronze = CategoryEntity(name: 'Bronze Tier');
    final transactions = [
      _tx(500, income: true, category: bronze),
      _tx(400, income: false, category: bronze),
      _tx(2000, income: true, category: gold),
      _tx(200, income: false, category: gold),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CategoryProfitabilityReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    final goldCenter = tester.getCenter(find.text('Gold Tier'));
    final bronzeCenter = tester.getCenter(find.text('Bronze Tier'));
    expect(goldCenter.dy, lessThan(bronzeCenter.dy));
  });
}
