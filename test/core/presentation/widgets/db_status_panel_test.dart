import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/db_status_panel.dart';

void main() {
  testWidgets('DbStatusPanel renders successfully with flat design specs',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: DbStatusPanel(),
      ),
    ));

    expect(find.byType(DbStatusPanel), findsOneWidget);
    expect(find.text("ObjectBox SDK"), findsOneWidget);
  });
}
