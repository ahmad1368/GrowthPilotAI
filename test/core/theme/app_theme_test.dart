import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growth_pilot_ai/core/theme/app_theme.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // GoogleFonts.inter() returns its TextStyle synchronously (what these
  // tests assert on) but also kicks off a background font-file fetch that
  // flutter_test's zone otherwise reports as an unrelated test failure.
  // Awaiting+swallowing it here keeps these tests independent of network
  // conditions instead of flaking on font-CDN availability.
  tearDown(() async {
    try {
      await GoogleFonts.pendingFonts();
    } catch (_) {}
  });

  group('AppTheme', () {
    test('light() and dark() provide the required static entry points (Issue #1 AC)', () {
      expect(AppTheme.light().brightness, Brightness.light);
      expect(AppTheme.dark().brightness, Brightness.dark);
    });

    test('useMaterial3 is enabled', () {
      expect(AppTheme.light().useMaterial3, isTrue);
      expect(AppTheme.dark().useMaterial3, isTrue);
    });

    test('colorScheme.primary matches the Issue #1 brand palette per brightness', () {
      expect(AppTheme.light().colorScheme.primary, AppDesignTokens.lightPrimary);
      expect(AppTheme.dark().colorScheme.primary, AppDesignTokens.darkPrimary);
    });

    test('colorScheme.error matches the Issue #1 brand palette per brightness', () {
      expect(AppTheme.light().colorScheme.error, AppDesignTokens.lightError);
      expect(AppTheme.dark().colorScheme.error, AppDesignTokens.darkError);
    });

    test('appBarTheme has zero elevation and a transparent background', () {
      final theme = AppTheme.light();
      expect(theme.appBarTheme.elevation, 0);
      expect(theme.appBarTheme.backgroundColor, Colors.transparent);
    });

    test('textTheme applies the Issue #1 typography spec globally', () {
      final textTheme = AppTheme.light().textTheme;
      expect(textTheme.headlineLarge?.fontSize, 24);
      expect(textTheme.headlineLarge?.fontWeight, FontWeight.bold);
      expect(textTheme.headlineLarge?.letterSpacing, -0.5);
      expect(textTheme.bodyMedium?.fontSize, 14);
      expect(textTheme.bodyMedium?.height, 1.5);
      expect(textTheme.labelSmall?.fontSize, 12);
      expect(textTheme.labelSmall?.fontWeight, FontWeight.w500);
    });
  });
}
