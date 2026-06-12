import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/widgets/source_item.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets('SourceItem renders correctly and triggers onTap',
      (tester) async {
    bool tapped = false;

    await tester.pumpWidget(
      ShadApp(
        home: Scaffold(
          body: SourceItem(
            icon: Icons.camera_alt_rounded,
            label: 'دوربین اسکنر',
            onTap: () => tapped = true,
          ),
        ),
      ),
    );

    expect(find.text('دوربین اسکنر'), findsOneWidget);
    await tester.tap(find.byType(ListTile));
    expect(tapped, true);
  });
}
