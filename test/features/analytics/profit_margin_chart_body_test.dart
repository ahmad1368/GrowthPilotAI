import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart_body.dart';

TransactionEntity _income(DateTime date, double amount) => TransactionEntity(
    amount: amount, date: date, description: 'in', dbType: 1);

void main() {
  testWidgets('defaults to Monthly and switches series when Daily is tapped',
      (tester) async {
    final transactions = [
      _income(DateTime(2026, 3, 1), 100),
      _income(DateTime(2026, 3, 2), 50),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: ProfitMarginChartBody(transactions: transactions)),
    ));

    // Monthly: both transactions fall in the same bucket -> 1 spot.
    var data = tester.widget<LineChart>(find.byType(LineChart)).data;
    expect(data.lineBarsData.single.spots, hasLength(1));

    await tester.tap(find.text('Daily'));
    await tester.pump();

    // Daily: two different calendar days -> 2 spots.
    data = tester.widget<LineChart>(find.byType(LineChart)).data;
    expect(data.lineBarsData.single.spots, hasLength(2));
  });
}
