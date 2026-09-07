import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_header.dart';
import 'package:growth_pilot_ai/features/settings/widgets/settings_section_card.dart';

/// [Issue #808] Covers the two dependency-free helper widgets extracted
/// from the former single-file SettingsScreen. The tab screens/sections
/// that consume them pull in GetX/GetIt-registered controllers (theme,
/// legal consent, subscription, support chat, etc.) and are exercised
/// live instead, per this repo's `/emulator-qa` workflow — not run here.
void main() {
  testWidgets('SettingsSectionHeader renders the title in uppercase', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: SettingsSectionHeader('Appearance')),
    ));

    expect(find.text('APPEARANCE'), findsOneWidget);
  });

  testWidgets('SettingsSectionCard renders its child', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: SettingsSectionCard(child: Text('Child content'))),
    ));

    expect(find.text('Child content'), findsOneWidget);
  });
}
