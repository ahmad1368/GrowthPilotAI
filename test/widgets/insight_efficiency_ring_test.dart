import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_efficiency_ring.dart';

void main() {
  testWidgets('shows the rounded percentage for the given value', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InsightEfficiencyRing(percent: 0.847, color: Colors.green),
      ),
    ));

    expect(find.text('85%'), findsOneWidget);
  });

  testWidgets('a value above 1.0 renders (ring visually caps at 100%, label does not)', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InsightEfficiencyRing(percent: 1.5, color: Colors.green),
      ),
    ));

    expect(find.text('150%'), findsOneWidget);
  });
}
