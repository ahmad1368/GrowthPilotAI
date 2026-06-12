import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/widgets/home_layout_app_bar.dart';

void main() {
  testWidgets(
      'HomeLayoutAppBar renders flat enterprise layout and shadtext title',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        appBar: HomeLayoutAppBar(
          unreadCount: 5,
          notifications: const [],
          onRefresh: () {},
          deleteNotification: (id, callback) {},
        ),
      ),
    ));

    expect(find.text("GrowthPilot AI"), findsOneWidget);
  });
}
