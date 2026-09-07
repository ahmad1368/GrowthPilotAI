import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';
import 'package:growth_pilot_ai/core/utils/locale_number_format.dart';

/// Covers Issue #813: [LocaleNumberFormat] existed for #429's "regional
/// number formatting" acceptance criterion but had zero tests and zero
/// call sites — these confirm it actually adapts output per locale before
/// any UI widget is trusted to rely on it.
void main() {
  group('LocaleNumberFormat.decimal', () {
    test('uses comma grouping and a dot decimal for en', () {
      expect(LocaleNumberFormat.decimal(1234.5, AppLocale.en), '1,234.5');
    });

    test('renders Persian digits for fa (not Latin digits)', () {
      final result = LocaleNumberFormat.decimal(1234.0, AppLocale.fa);
      expect(result, isNot(contains('1')));
      expect(result, contains('۱'));
    });

    test('does not throw for every supported locale and returns non-empty output', () {
      for (final locale in AppLocale.values) {
        expect(LocaleNumberFormat.decimal(1000.25, locale), isNotEmpty);
      }
    });
  });

  group('LocaleNumberFormat.currency', () {
    test('keeps the grouped amount intact for en/CAD', () {
      expect(LocaleNumberFormat.currency(1250.0, AppLocale.en), contains('1,250'));
    });

    test('does not throw for every supported locale and returns non-empty output', () {
      for (final locale in AppLocale.values) {
        expect(LocaleNumberFormat.currency(42.5, locale), isNotEmpty);
      }
    });
  });

  group('LocaleNumberFormat.date', () {
    test('formats a known date for en without throwing', () {
      final result = LocaleNumberFormat.date(DateTime(2026, 3, 5), AppLocale.en);
      expect(result, contains('2026'));
    });
  });
}
