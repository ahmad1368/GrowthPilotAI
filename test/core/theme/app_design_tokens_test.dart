import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/theme/app_design_tokens.dart';

void main() {
  group('AppDesignTokens', () {
    test('background() resolves the correct token per brightness', () {
      expect(AppDesignTokens.background(Brightness.dark), AppDesignTokens.darkBackground);
      expect(AppDesignTokens.background(Brightness.light), AppDesignTokens.lightBackground);
    });

    test('card() resolves the correct token per brightness', () {
      expect(AppDesignTokens.card(Brightness.dark), AppDesignTokens.darkCard);
      expect(AppDesignTokens.card(Brightness.light), AppDesignTokens.lightCard);
    });

    test('spacing scale is strictly increasing (4pt grid)', () {
      final scale = [
        AppDesignTokens.spaceXs,
        AppDesignTokens.spaceSm,
        AppDesignTokens.spaceMd,
        AppDesignTokens.spaceLg,
        AppDesignTokens.spaceXl,
        AppDesignTokens.spaceXxl,
      ];
      for (var i = 1; i < scale.length; i++) {
        expect(scale[i], greaterThan(scale[i - 1]));
      }
    });

    test('radius scale is strictly increasing', () {
      expect(AppDesignTokens.radiusSm, lessThan(AppDesignTokens.radiusMd));
      expect(AppDesignTokens.radiusMd, lessThan(AppDesignTokens.radiusLg));
    });

    test('brand palette resolvers return the Issue #784 warm spec hex values', () {
      expect(AppDesignTokens.primary(Brightness.light), const Color(0xFFF97316));
      expect(AppDesignTokens.primary(Brightness.dark), const Color(0xFFEA580C));
      expect(AppDesignTokens.secondary(Brightness.light), const Color(0xFFD97706));
      expect(AppDesignTokens.secondary(Brightness.dark), const Color(0xFFFBBF24));
      expect(AppDesignTokens.error(Brightness.light), const Color(0xFFDC2626));
      expect(AppDesignTokens.error(Brightness.dark), const Color(0xFFF87171));
      expect(AppDesignTokens.textPrimary(Brightness.light), const Color(0xFF2A1607));
      expect(AppDesignTokens.textPrimary(Brightness.dark), const Color(0xFFFDF4E7));
    });

    test('success token stays distinct from primary/secondary (Issue #784)', () {
      expect(AppDesignTokens.success, isNot(AppDesignTokens.lightPrimary));
      expect(AppDesignTokens.success, isNot(AppDesignTokens.darkPrimary));
      expect(AppDesignTokens.success, isNot(AppDesignTokens.lightSecondary));
      expect(AppDesignTokens.success, isNot(AppDesignTokens.darkSecondary));
    });
  });
}
