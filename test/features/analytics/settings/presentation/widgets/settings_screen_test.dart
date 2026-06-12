import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/settings/presentation/widgets/settings_screen.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  testWidgets(
      'SettingsScreen renders typography elements and flat card lists accurately',
      (tester) async {
    await tester.pumpWidget(
      const ShadApp(
        home: SettingsScreen(),
      ),
    );

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('APPEARANCE'), findsOneWidget);
    expect(find.byType(ShadCard), findsAtLeastNWidgets(1));
  });
}
