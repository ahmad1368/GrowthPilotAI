import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/core/widgets/app_notifier.dart';

/// Covers Issue #784's icon-led notification helper — each status type
/// must surface a distinct, recognizable icon rather than relying on
/// color/text alone.
void main() {
  setUp(() => Get.testMode = true);
  tearDown(() => Get.reset());

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(GetMaterialApp(home: const SizedBox()));
    await tester.pumpAndSettle();
  }

  testWidgets('success notification shows a check-circle icon', (tester) async {
    await pumpApp(tester);
    AppNotifier.show(
        title: 'Saved', message: 'Done', type: AppNotificationType.success);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
  });

  testWidgets('error notification shows an error icon', (tester) async {
    await pumpApp(tester);
    AppNotifier.show(
        title: 'Failed', message: 'Oops', type: AppNotificationType.error);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.error_rounded), findsOneWidget);
  });

  testWidgets('warning notification shows a warning icon', (tester) async {
    await pumpApp(tester);
    AppNotifier.show(
        title: 'Careful', message: 'Check this', type: AppNotificationType.warning);
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.warning_amber_rounded), findsOneWidget);
  });

  testWidgets('info notification (default type) shows an info icon', (tester) async {
    await pumpApp(tester);
    AppNotifier.show(title: 'Heads up', message: 'FYI');
    await tester.pumpAndSettle();

    expect(find.byIcon(Icons.info_rounded), findsOneWidget);
  });

  testWidgets('renders the title and message text', (tester) async {
    await pumpApp(tester);
    AppNotifier.show(title: 'Account deleted', message: 'Bye for now');
    await tester.pumpAndSettle();

    expect(find.text('Account deleted'), findsOneWidget);
    expect(find.text('Bye for now'), findsOneWidget);
  });

  test('success uses the dedicated success token, not primary/secondary', () {
    // Regression guard: success must stay visually distinct from the warm
    // primary/secondary accents introduced in Issue #784.
    expect(AppDesignTokens.success, isNot(AppDesignTokens.lightPrimary));
    expect(AppDesignTokens.success, isNot(AppDesignTokens.darkPrimary));
  });
}
