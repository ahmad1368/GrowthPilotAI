import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/business_compass_metrics.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/business_radar_chart.dart';

/// Issue #115's config toggle: showSectorOverlay controls whether the
/// sector "Ghost" dataset renders at all.
void main() {
  const user = BusinessCompassMetrics(
    liquidityRatio: 0.7,
    burnVelocity: 0.4,
    vendorDiversity: 0.2,
    paymentPunctuality: 0.85,
    profitMargin: 0.5,
  );
  const sector = BusinessCompassMetrics(
    liquidityRatio: 0.8,
    burnVelocity: 0.45,
    vendorDiversity: 0.9,
    paymentPunctuality: 0.9,
    profitMargin: 0.55,
  );

  Future<RadarChartData> pump(WidgetTester tester, bool showSector) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: BusinessRadarChart(
          userMetrics: user,
          sectorMetrics: sector,
          showSectorOverlay: showSector,
        ),
      ),
    ));
    return tester.widget<RadarChart>(find.byType(RadarChart)).data;
  }

  testWidgets('showSectorOverlay: true renders both datasets',
      (tester) async {
    final data = await pump(tester, true);
    expect(data.dataSets, hasLength(2));
  });

  testWidgets('showSectorOverlay: false renders only the user dataset',
      (tester) async {
    final data = await pump(tester, false);
    expect(data.dataSets, hasLength(1));
    expect(data.dataSets.single.dataEntries.map((e) => e.value),
        user.toList());
  });

  testWidgets('defaults to showing the sector overlay when unspecified',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: BusinessRadarChart(userMetrics: user, sectorMetrics: sector),
      ),
    ));
    final data = tester.widget<RadarChart>(find.byType(RadarChart)).data;
    expect(data.dataSets, hasLength(2));
  });
}
