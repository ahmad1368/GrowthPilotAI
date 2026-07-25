import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/data/entities/transaction_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/traffic_report_body.dart';

TransactionEntity _txAt(DateTime date) =>
    TransactionEntity(amount: 10, date: date, description: 'x');

void main() {
  testWidgets('defaults to By Hour (24 bars), switches to By Day (7 bars)',
      (tester) async {
    final transactions = [
      _txAt(DateTime(2026, 3, 5, 14, 0)),
      _txAt(DateTime(2026, 3, 6, 9, 0)),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: TrafficReportBody(transactions: transactions)),
    ));

    var data = tester.widget<BarChart>(find.byType(BarChart)).data;
    expect(data.barGroups, hasLength(24));

    await tester.tap(find.text('By Day'));
    await tester.pump();

    data = tester.widget<BarChart>(find.byType(BarChart)).data;
    expect(data.barGroups, hasLength(7));
  });
}
