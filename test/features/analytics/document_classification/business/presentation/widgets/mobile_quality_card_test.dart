import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/mobile_quality_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('MobileQualityCard renders fully on mobile view', (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: MobileQualityCard(statusText: 'تحلیل سند فاکتور...'),
        ),
      ),
    );

    expect(find.text('تحلیل سند فاکتور...'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });
}
