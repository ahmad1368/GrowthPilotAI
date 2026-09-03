import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/theme_controller.dart';
import 'package:growth_pilot_ai/widgets/theme_toggle.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    Get.reset();
  });

  // GetMaterialApp (not plain MaterialApp) + a registered ThemeController:
  // ThemeToggle now routes its tap through Get.find<ThemeController>()
  // (Issue #2), which itself resolves AdaptiveTheme via Get.context — that
  // only works when GetX owns the navigator.
  Future<void> pumpToggle(WidgetTester tester) async {
    Get.put(ThemeController());
    await tester.pumpWidget(
      AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) => GetMaterialApp(
          theme: light,
          darkTheme: dark,
          home: const Scaffold(body: Center(child: ThemeToggle())),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  group('ThemeToggle', () {
    testWidgets('has a Semantics label describing the action', (tester) async {
      await pumpToggle(tester);
      expect(find.bySemanticsLabel('Switch to Dark Mode'), findsOneWidget);
    });

    testWidgets('has at least a 44x44 tappable hit area', (tester) async {
      await pumpToggle(tester);
      final size = tester.getSize(find.byType(GestureDetector));
      expect(size.width, greaterThanOrEqualTo(44));
      expect(size.height, greaterThanOrEqualTo(44));
    });

    testWidgets('triggers haptic feedback and toggles the theme on tap', (tester) async {
      final calls = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, (call) async {
        calls.add(call);
        return null;
      });
      addTearDown(() {
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(SystemChannels.platform, null);
      });

      await pumpToggle(tester);
      final context = tester.element(find.byType(ThemeToggle));
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.light);

      await tester.tap(find.byType(ThemeToggle));
      await tester.pumpAndSettle();

      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.dark);
      expect(calls.any((c) => c.method == 'HapticFeedback.vibrate'), isTrue);
    });
  });
}
