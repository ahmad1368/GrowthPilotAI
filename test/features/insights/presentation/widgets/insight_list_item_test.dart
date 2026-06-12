import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/models/insight_model.dart';
import 'package:growth_pilot_ai/widgets/insight/insight_list_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
      'InsightListItem renders model content and responds to tap gesture',
      (WidgetTester tester) async {
    final mockInsight = InsightModel(
        id: 25556,
        title: "Test Financial Title",
        description: "Test Financial Analytics Description",
        efficiency: "Correct error");

    bool isTapped = false;

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: InsightListItem(
            data: mockInsight,
            isSelected: true,
            onTap: () => isTapped = true,
          ),
        ),
      ),
    );

    // ارزیابی صحت نمایش داده‌های مدل و کامپوننت هوش مصنوعی
    expect(find.text("Test Financial Title"), findsOneWidget);
    expect(find.text("Test Financial Analytics Description"), findsOneWidget);
    expect(find.byType(ShadCard), findsOneWidget);

    // تست محرک کلیک لایه کاربری
    await tester.tap(find.byType(GestureDetector));
    await tester.pumpAndSettle();
    expect(isTapped, true);
  });
}
