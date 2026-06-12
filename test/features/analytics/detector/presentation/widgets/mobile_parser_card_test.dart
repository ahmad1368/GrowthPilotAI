import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:growth_pilot_ai/features/detector/models/presentation/widgets/mobile_parser_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('MobileParserCard renders data lists correctly on mobile view',
      (tester) async {
    final mockData = FinancialParserResult(
      extractedDate: DateTime(2026, 06, 02),
      currency: 'EUR',
    );

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: MobileParserCard(data: mockData),
        ),
      ),
    );

    expect(find.text('تاریخ: 2026-06-02'), findsOneWidget);
    expect(find.text('ارز مبنا: EUR'), findsOneWidget);
  });
}
