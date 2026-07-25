import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/category_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/category_elasticity_report_widget.dart';

TransactionEntity _tx(double amount, DateTime date, {CategoryEntity? category}) {
  final tx =
      TransactionEntity(amount: amount, date: date, description: 'x', dbType: 1);
  if (category != null) tx.category.target = category;
  return tx;
}

void main() {
  testWidgets('shows a placeholder when there is no categorized revenue',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: CategoryElasticityReportWidget(
            data: {'transactions': <TransactionEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No categorized revenue yet.'), findsOneWidget);
  });

  testWidgets('shows a warning icon for an elastic category', (tester) async {
    final consulting = CategoryEntity(name: 'Consulting');
    final transactions = [
      _tx(100, DateTime(2026, 1, 1), category: consulting),
      _tx(100, DateTime(2026, 1, 5), category: consulting),
      _tx(200, DateTime(2026, 2, 1), category: consulting),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CategoryElasticityReportWidget(
            data: {'transactions': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('Consulting'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });
}
