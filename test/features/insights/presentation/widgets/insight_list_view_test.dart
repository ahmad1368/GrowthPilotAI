import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:growth_pilot_ai/features/insights/presentation/widgets/insight_list_view.dart';

void main() {
  testWidgets('InsightListView renders insights correctly via Shadcn Theme',
      (WidgetTester tester) async {
    final mockInsights = [
      InsightModel(
          id: 1, title: "Insight 1", description: "Desc 1", efficiency: "90%"),
    ];

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: InsightListView(
            selectedIndex: 0,
            insights: mockInsights,
            onChanged: (val) {},
            title: "تست آنالیتیکس",
          ),
        ),
      ),
    );

    expect(find.text("تست آنالیتیکس"), findsOneWidget);
    expect(find.byType(CustomScrollView), findsOneWidget);
  });
}
