import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/pages/profile_placeholder_page.dart';

/// Covers Issue #815: the Profile tab previously fell through to the same
/// InsightPage content as Home, so tapping it looked like nothing happened.
void main() {
  testWidgets('shows the profile icon and a title/subtitle instead of a blank screen',
      (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ProfilePlaceholderPage()));

    expect(find.byIcon(Icons.person_rounded), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
  });
}
