import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/detect_system_app_locale.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

void main() {
  group('DetectSystemAppLocale', () {
    test('matches en-CA to English (Issue #179 AC)', () {
      expect(DetectSystemAppLocale.call(const Locale('en', 'CA')), AppLocale.en);
    });

    test('matches fr-CA to French (Issue #179 AC)', () {
      expect(DetectSystemAppLocale.call(const Locale('fr', 'CA')), AppLocale.fr);
    });

    test('matches fa-IR to Farsi (Issue #179 AC)', () {
      expect(DetectSystemAppLocale.call(const Locale('fa', 'IR')), AppLocale.fa);
    });

    test('falls back to English for an unsupported system language', () {
      expect(DetectSystemAppLocale.call(const Locale('de', 'DE')), AppLocale.en);
    });
  });
}
