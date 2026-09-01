import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/features/onboarding/widgets/language_option_tile.dart';

void main() {
  group('LanguageOptionTile', () {
    testWidgets('shows the suggested badge when isSuggested is true (Issue #179 AC)', (tester) async {
      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: LanguageOptionTile(locale: AppLocale.fr, isSuggested: true, onTap: () {}),
        ),
      ));

      // No translation bundle is registered in this test, so `.tr`
      // falls back to returning the key itself — still enough to
      // assert the badge is present at all.
      expect(find.text('onboarding_suggested_language'), findsOneWidget);
    });

    testWidgets('hides the suggested badge when isSuggested is false', (tester) async {
      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: LanguageOptionTile(locale: AppLocale.fr, onTap: () {}),
        ),
      ));

      expect(find.text('onboarding_suggested_language'), findsNothing);
    });

    testWidgets('invokes onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(GetMaterialApp(
        home: Scaffold(
          body: LanguageOptionTile(locale: AppLocale.en, onTap: () => tapped = true),
        ),
      ));

      await tester.tap(find.byType(ListTile));
      expect(tapped, isTrue);
    });
  });
}
