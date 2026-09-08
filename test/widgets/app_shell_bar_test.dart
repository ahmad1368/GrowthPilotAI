import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';
import 'package:growth_pilot_ai/widgets/app_shell_bar.dart';

void main() {
  Future<void> pumpBar(
    WidgetTester tester, {
    required double opacity,
    Brightness brightness = Brightness.light,
  }) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
        home: Scaffold(appBar: AppShellBar(title: 'Home', opacity: opacity)),
      ),
    );
  }

  group('AppShellBar', () {
    testWidgets('is fully transparent at opacity 0.0', (tester) async {
      await pumpBar(tester, opacity: 0.0);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect((appBar.backgroundColor as Color).a, 0.0);
    });

    testWidgets('light: background lerps to AppDesignTokens.lightBackground at opacity 1.0', (tester) async {
      await pumpBar(tester, opacity: 1.0, brightness: Brightness.light);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, AppDesignTokens.lightBackground);
    });

    testWidgets('dark: background lerps to AppDesignTokens.darkBackground at opacity 1.0', (tester) async {
      await pumpBar(tester, opacity: 1.0, brightness: Brightness.dark);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.backgroundColor, AppDesignTokens.darkBackground);
    });

    testWidgets('light: systemOverlayStyle keeps status bar icons dark for contrast', (tester) async {
      await pumpBar(tester, opacity: 0.5, brightness: Brightness.light);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.systemOverlayStyle, SystemUiOverlayStyle.dark);
    });

    testWidgets('dark: systemOverlayStyle keeps status bar icons light for contrast', (tester) async {
      await pumpBar(tester, opacity: 0.5, brightness: Brightness.dark);
      final appBar = tester.widget<AppBar>(find.byType(AppBar));
      expect(appBar.systemOverlayStyle, SystemUiOverlayStyle.light);
    });
  });

  // Covers Issue #835: the app-bar title icon used to be purely decorative.
  group('AppShellBar title icon', () {
    testWidgets('tapping the title icon fires onTitleIconTap', (tester) async {
      var tapped = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppShellBar(
            titleIcon: Icons.trending_up_rounded,
            onTitleIconTap: () => tapped = true,
            opacity: 1.0,
          ),
        ),
      ));

      await tester.tap(find.byIcon(Icons.trending_up_rounded));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('renders without a tap handler when none is given', (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          appBar: AppShellBar(titleIcon: Icons.trending_up_rounded, opacity: 1.0),
        ),
      ));

      expect(find.byIcon(Icons.trending_up_rounded), findsOneWidget);
    });
  });
}
