import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/insight_card.dart';

void main() {
  testWidgets('InsightCard renders flat layout with proper analytics details',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: InsightCard(
          title: "Test Optimization",
          description: "Verify description tracking code logic.",
          efficiency: "High Priority",
        ),
      ),
    ));

    expect(find.text("Test Optimization"), findsOneWidget);
    expect(find.text("High Priority"), findsOneWidget);
  });
}
