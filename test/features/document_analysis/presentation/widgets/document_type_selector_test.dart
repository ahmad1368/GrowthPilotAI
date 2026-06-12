import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_analysis/presentation/widgets/document_type_selector.dart';

void main() {
  testWidgets(
      'DocumentTypeSelector renders text label and flat shadcn dropdown components',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: DocumentTypeSelector(
          initialType: "Invoice",
          availableTypes: const ["Invoice", "Receipt", "Contract"],
          onTypeSelected: (_) {},
          onAddNew: () {},
        ),
      ),
    ));

    expect(find.text("نوع سند شناسایی شده:"), findsOneWidget);
    expect(find.text("Invoice"), findsOneWidget);
  });
}
