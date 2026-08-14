import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/profit_margin_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/profit_margin_chart.dart';

void main() {
  testWidgets('shows a placeholder message when there are no points',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: ProfitMarginChart(points: [])),
    ));

    expect(find.text('No transactions yet'), findsOneWidget);
    expect(find.byType(LineChart), findsNothing);
  });

  testWidgets('plots one spot per point and keeps a symmetric Y range',
      (tester) async {
    // periodStart isn't read by the chart itself, only marginPercent.
    final points = [
      ProfitMarginPoint(periodStart: DateTime(2026, 1, 1), marginPercent: 5),
      ProfitMarginPoint(periodStart: DateTime(2026, 2, 1), marginPercent: -20),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: ProfitMarginChart(points: points)),
    ));

    final data = tester.widget<LineChart>(find.byType(LineChart)).data;
    expect(data.lineBarsData.single.spots, hasLength(2));
    expect(data.minY, -data.maxY); // symmetric around zero
    expect(data.maxY, greaterThanOrEqualTo(20 * 1.2));
  });
}
