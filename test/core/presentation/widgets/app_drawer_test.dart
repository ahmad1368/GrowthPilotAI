import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/presentation/widgets/app_drawer.dart';

void main() {
  testWidgets('AppDrawer renders correctly within a test context environment',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        drawer: AppDrawer(),
      ),
    ));

    final drawerFinder = find.byType(AppDrawer);
    expect(drawerFinder, findsOneWidget);
  });
}
