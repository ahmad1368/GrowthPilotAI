import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/controllers/theme_controller.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    // AdaptiveTheme persists the selected mode via SharedPreferencesAsync;
    // an in-memory fake avoids depending on a real platform channel in tests.
    SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty();
  });

  tearDown(() {
    Get.reset();
  });

  Future<BuildContext> pumpApp(WidgetTester tester) async {
    late BuildContext capturedContext;
    await tester.pumpWidget(
      AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: AdaptiveThemeMode.light,
        builder: (light, dark) => GetMaterialApp(
          theme: light,
          darkTheme: dark,
          home: Builder(builder: (context) {
            capturedContext = context;
            return const SizedBox();
          }),
        ),
      ),
    );
    await tester.pumpAndSettle();
    return capturedContext;
  }

  group('ThemeController', () {
    testWidgets('toggleTheme() switches from light to dark', (tester) async {
      final context = await pumpApp(tester);
      Get.put(ThemeController());

      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.light);
      Get.find<ThemeController>().toggleTheme();
      await tester.pumpAndSettle();
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.dark);
    });

    testWidgets('toggleTheme() switches back from dark to light', (tester) async {
      final context = await pumpApp(tester);
      Get.put(ThemeController());

      Get.find<ThemeController>().toggleTheme();
      await tester.pumpAndSettle();
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.dark);

      Get.find<ThemeController>().toggleTheme();
      await tester.pumpAndSettle();
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.light);
    });

    testWidgets('setSystemTheme() reverts to following the OS setting', (tester) async {
      final context = await pumpApp(tester);
      Get.put(ThemeController());

      Get.find<ThemeController>().toggleTheme();
      await tester.pumpAndSettle();
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.dark);

      Get.find<ThemeController>().setSystemTheme();
      await tester.pumpAndSettle();
      expect(AdaptiveTheme.of(context).mode, AdaptiveThemeMode.system);
    });
  });
}
