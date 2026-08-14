import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/linked_account_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/financial_health_report_widget.dart';

LinkedAccountEntity _account(String type, double balance, {String id = 'a1'}) =>
    LinkedAccountEntity(
      accountId: id,
      institutionName: 'Bank',
      officialName: 'Account',
      mask: '0000',
      accountType: type,
      currentBalance: balance,
    );

void main() {
  testWidgets('shows a placeholder when there are no linked accounts', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: FinancialHealthReportWidget(
            data: {'accounts': <LinkedAccountEntity>[]}, title: 'x'),
      ),
    ));

    expect(find.text('No linked accounts yet.'), findsOneWidget);
  });

  testWidgets('shows the health score and Healthy label for a strong ratio', (tester) async {
    final transactions = [
      _account('depository', 2000, id: 'a1'),
      _account('credit', 500, id: 'a2'),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FinancialHealthReportWidget(data: {'accounts': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('100'), findsOneWidget);
    expect(find.text('Healthy'), findsOneWidget);
  });

  testWidgets('shows At Risk for a weak ratio', (tester) async {
    final transactions = [
      _account('depository', 100, id: 'a1'),
      _account('credit', 1000, id: 'a2'),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: FinancialHealthReportWidget(data: {'accounts': transactions}, title: 'x'),
      ),
    ));

    expect(find.text('At Risk'), findsOneWidget);
  });
}
