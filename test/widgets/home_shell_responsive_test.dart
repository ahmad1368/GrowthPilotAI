import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/widgets/app_shell_bar.dart';
import 'package:growth_pilot_ai/widgets/home_bottom_nav.dart';

/// Issue #9 — the rebuilt flat app-shell chrome (Issues #5/#6) must not
/// overflow at mobile or tablet widths, in light or dark.
void main() {
  Future<void> pumpShellAt(
    WidgetTester tester, {
    required double width,
    required Brightness brightness,
  }) async {
    await tester.binding.setSurfaceSize(Size(width, 800));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await tester.pumpWidget(MaterialApp(
      theme: ThemeData(brightness: brightness),
      home: const Scaffold(
        appBar: AppShellBar(title: 'GrowthPilot AI', opacity: 1.0),
        bottomNavigationBar: HomeBottomNav(currentIndex: 0),
        body: SizedBox(),
      ),
    ));
  }

  for (final width in [360.0, 800.0]) {
    for (final brightness in [Brightness.light, Brightness.dark]) {
      testWidgets('shell chrome fits at ${width}px ($brightness)',
          (tester) async {
        await pumpShellAt(tester, width: width, brightness: brightness);

        expect(tester.takeException(), isNull);
        expect(find.byType(AppShellBar), findsOneWidget);
        expect(find.byType(HomeBottomNav), findsOneWidget);
      });
    }
  }
}
