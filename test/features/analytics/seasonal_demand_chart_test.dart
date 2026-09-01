import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/seasonal_demand_point.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/seasonal_demand_chart.dart';

void main() {
  testWidgets('renders one bar group per month', (tester) async {
    final points = [
      for (var m = 1; m <= 12; m++)
        SeasonalDemandPoint(month: m, averageRevenue: m * 10.0, isPeak: m == 12),
    ];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: SeasonalDemandChart(points: points)),
    ));

    final data = tester.widget<BarChart>(find.byType(BarChart)).data;
    expect(data.barGroups, hasLength(12));
  });

  testWidgets('the peak bar uses the theme primary color, others do not',
      (tester) async {
    final points = [
      for (var m = 1; m <= 12; m++)
        SeasonalDemandPoint(month: m, averageRevenue: 10, isPeak: m == 3),
    ];
    const primary = Colors.deepPurple;

    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.light(primary: primary)),
      home: Scaffold(body: SeasonalDemandChart(points: points)),
    ));

    final data = tester.widget<BarChart>(find.byType(BarChart)).data;
    final peakGroup = data.barGroups.firstWhere((g) => g.x == 2); // month 3
    expect(peakGroup.barRods.single.color, primary);
    final otherGroup = data.barGroups.firstWhere((g) => g.x == 0);
    expect(otherGroup.barRods.single.color, isNot(primary));
  });
}
