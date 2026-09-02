import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/pages/main_wrapper.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.put(NavigationController());
  });

  tearDown(() {
    Get.reset();
  });

  Future<void> pumpNav(WidgetTester tester, {Brightness brightness = Brightness.light}) async {
    await tester.pumpWidget(
      GetMaterialApp(
        theme: ThemeData(brightness: brightness),
        home: const Scaffold(bottomNavigationBar: HomeBottomNav(currentIndex: 0)),
      ),
    );
  }

  group('HomeBottomNav', () {
    testWidgets('renders flat (no glassmorphism/BackdropFilter)', (tester) async {
      await pumpNav(tester);
      expect(find.byType(BackdropFilter), findsNothing);
    });

    testWidgets('uses AppDesignTokens.card() background per brightness', (tester) async {
      await pumpNav(tester, brightness: Brightness.light);
      final container = tester.widget<Container>(
        find.ancestor(of: find.byType(BottomNavigationBar), matching: find.byType(Container)).first,
      );
      final decoration = container.decoration as BoxDecoration;
      expect(decoration.color, AppDesignTokens.lightCard);

      await pumpNav(tester, brightness: Brightness.dark);
      final darkContainer = tester.widget<Container>(
        find.ancestor(of: find.byType(BottomNavigationBar), matching: find.byType(Container)).first,
      );
      final darkDecoration = darkContainer.decoration as BoxDecoration;
      expect(darkDecoration.color, AppDesignTokens.darkCard);
    });

    testWidgets('tapping an item triggers haptic feedback and updates the controller', (tester) async {
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

      await pumpNav(tester);
      await tester.tap(find.text('Insights'));
      await tester.pumpAndSettle();

      expect(Get.find<NavigationController>().currentIndex.value, 1);
      expect(calls.any((c) => c.method == 'HapticFeedback.vibrate'), isTrue);
    });
  });
}
