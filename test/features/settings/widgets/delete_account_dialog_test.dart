import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_shad_theme.dart';
import 'package:growth_pilot_ai/features/settings/widgets/delete_account_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

// ShadTheme lives in `builder:` (not just around `home:`) because
// showShadDialog pushes onto the root Navigator, which sits outside any
// ShadTheme wrapped only around `home` — matching the app-wide fix in
// main.dart's GetMaterialApp.
Widget _harness() => GetMaterialApp(
      builder: (context, child) => ShadTheme(
        data: AppShadTheme.build(Brightness.light),
        child: child!,
      ),
      home: Builder(
        builder: (context) => ShadButton(
          onPressed: () => showDeleteAccountDialog(context),
          child: const Text('Open'),
        ),
      ),
    );

void main() {
  group('DeleteAccountDialog (Issue #189)', () {
    testWidgets('the Delete button starts disabled', (tester) async {
      await tester.pumpWidget(_harness());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final deleteButton = tester.widget<ShadButton>(find.widgetWithText(ShadButton, 'Delete Everything'));
      expect(deleteButton.enabled, isFalse);
    });

    testWidgets('typing DELETE enables the Delete button', (tester) async {
      await tester.pumpWidget(_harness());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(ShadInput), 'DELETE');
      await tester.pump();

      final deleteButton = tester.widget<ShadButton>(find.widgetWithText(ShadButton, 'Delete Everything'));
      expect(deleteButton.enabled, isTrue);
    });

    testWidgets('Cancel closes the dialog without confirming', (tester) async {
      await tester.pumpWidget(_harness());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Delete Account'), findsNothing);
    });
  });
}
