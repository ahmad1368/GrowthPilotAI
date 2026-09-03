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

    test('brand palette resolvers return the Issue #1 spec hex values', () {
      expect(AppDesignTokens.primary(Brightness.light), const Color(0xFF2563EB));
      expect(AppDesignTokens.primary(Brightness.dark), const Color(0xFF3B82F6));
      expect(AppDesignTokens.secondary(Brightness.light), const Color(0xFF10B981));
      expect(AppDesignTokens.secondary(Brightness.dark), const Color(0xFF34D399));
      expect(AppDesignTokens.error(Brightness.light), const Color(0xFFEF4444));
      expect(AppDesignTokens.error(Brightness.dark), const Color(0xFFF87171));
      expect(AppDesignTokens.textPrimary(Brightness.light), const Color(0xFF1E293B));
      expect(AppDesignTokens.textPrimary(Brightness.dark), const Color(0xFFF1F5F9));
    });
  });
}
