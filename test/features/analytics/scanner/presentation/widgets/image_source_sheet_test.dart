import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/scanner/screens/presentation/widgets/presentation/widgets/image_source_sheet.dart';

void main() {
  testWidgets('ImageSourceSheet bottom sheet UI elements verify flat structure',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ImageSourceSheet(onSourceSelected: (_) {}),
      ),
    ));

    expect(find.byType(ImageSourceSheet), findsOneWidget);
    expect(find.text("انتخاب منبع تصویر"), findsOneWidget);
  });
}
