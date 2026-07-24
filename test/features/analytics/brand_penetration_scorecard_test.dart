import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/brand_penetration_index.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/brand_penetration_scorecard.dart';

void main() {
  testWidgets('shows the rounded index percent and formatted amounts',
      (tester) async {
    const index = BrandPenetrationIndex(
      userVolume: 14000,
      neighborhoodBenchmarkVolume: 28000,
      indexPercent: 50,
    );

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: BrandPenetrationScorecard(index: index)),
    ));

    expect(find.text('50%'), findsOneWidget);
    expect(find.textContaining('\$28,000.00'), findsOneWidget);
    expect(find.textContaining('\$14,000.00'), findsOneWidget);
  });

  testWidgets('the progress bar is capped at 1.0 even when the index exceeds 100%',
      (tester) async {
    const index = BrandPenetrationIndex(
      userVolume: 60000,
      neighborhoodBenchmarkVolume: 28000,
      indexPercent: 214,
    );

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: BrandPenetrationScorecard(index: index)),
    ));

    final bar = tester.widget<LinearProgressIndicator>(
        find.byType(LinearProgressIndicator));
    expect(bar.value, 1.0);
    expect(find.text('214%'), findsOneWidget);
  });
}
