import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/classification_status_panel.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('ClassificationStatusPanel renders loading state when active',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: ClassificationStatusPanel(isChecking: true),
        ),
      ),
    );

    expect(find.text('Checking image quality...'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('ClassificationStatusPanel returns shrinked box when inactive',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: Scaffold(
          body: ClassificationStatusPanel(isChecking: false),
        ),
      ),
    );

    expect(find.text('Checking image quality...'), findsNothing);
  });
}
