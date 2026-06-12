import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/notifications/presentation/widgets/notification_sheet.dart';

void main() {
  testWidgets(
      'NotificationSheet displays empty message placeholder in flat architecture',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: NotificationSheet(
            notifications: const [], onRead: (_) {}, onDelete: (_) {}),
      ),
    ));

    expect(find.text("NOTIFICATIONS"), findsOneWidget);
    expect(find.text("No messages yet"), findsOneWidget);
  });
}
