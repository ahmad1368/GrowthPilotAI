import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/analytics/presentation/widgets/insight_info_card.dart';

void main() {
  testWidgets(
      'InsightInfoCard renders business metric and text with flat shadcn theme',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: InsightInfoCard(
          title: "Conversion Rate",
          value: "24.5%",
          icon: Icons.trending_up,
          color: Colors.blue,
        ),
      ),
    ));

    expect(find.text("Conversion Rate"), findsOneWidget);
    expect(find.text("24.5%"), findsOneWidget);
  });
}
