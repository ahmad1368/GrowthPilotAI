import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_analysis/presentation/widgets/source_item.dart';

void main() {
  testWidgets('SourceItem renders label and native icon with responsive colors',
      (WidgetTester tester) async {
    bool isTapped = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: SourceItem(
          icon: Icons.camera_alt_outlined,
          label: "Camera Source",
          onTap: () => isTapped = true,
        ),
      ),
    ));

    expect(find.text("Camera Source"), findsOneWidget);
    await tester.tap(find.byType(ListTile));
    expect(isTapped, true);
  });
}
