import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/overhead_report_widget.dart';

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
        body: OverheadReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No expense transactions yet.'), findsOneWidget);
  });

  testWidgets('lists the highest ratio-to-revenue category first',
      (tester) async {
    final rent = CategoryEntity(name: 'Rent');
    final utilities = CategoryEntity(name: 'Utilities');
    final transactions = [
      _tx(1000, income: true),
      _tx(100, income: false, category: utilities), // 10%
      _tx(400, income: false, category: rent), // 40%
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OverheadReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    final rentCenter = tester.getCenter(find.text('Rent'));
    final utilitiesCenter = tester.getCenter(find.text('Utilities'));
    expect(rentCenter.dy, lessThan(utilitiesCenter.dy));
  });

  testWidgets('shows a warning icon for a category over the alert threshold',
      (tester) async {
    final rent = CategoryEntity(name: 'Rent');
    final transactions = [
      _tx(1000, income: true),
      _tx(200, income: false, category: rent), // 20% > 15%
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OverheadReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });

  testWidgets('shows the total overhead-to-revenue summary stat',
      (tester) async {
    final rent = CategoryEntity(name: 'Rent');
    final transactions = [
      _tx(1000, income: true),
      _tx(300, income: false, category: rent),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: OverheadReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Total Overhead vs. Revenue'), findsOneWidget);
    expect(find.text('30.0%'), findsOneWidget);
  });
}
