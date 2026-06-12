import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/detector/models/financial_parser_result.dart';
import 'package:growth_pilot_ai/features/detector/models/presentation/widgets/desktop_parser_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('DesktopParserCard renders financial values accurately',
      (tester) async {
    final mockData = FinancialParserResult(
      extractedDate: DateTime(2026, 06, 02),
      currency: 'USD',
    );

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: DesktopParserCard(data: mockData),
        ),
      ),
    );

    expect(find.text('تاریخ تراکنش: 2026-06-02'), findsOneWidget);
    expect(find.text('ارز شناسایی شده: USD'), findsOneWidget);
  });
}
