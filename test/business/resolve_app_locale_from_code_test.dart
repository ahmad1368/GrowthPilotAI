import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/resolve_app_locale_from_code.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

void main() {
  test('resolves a known language code', () {
    expect(ResolveAppLocaleFromCode.call('fr'), AppLocale.fr);
    expect(ResolveAppLocaleFromCode.call('ar'), AppLocale.ar);
  });

  test('falls back to English for an unknown code', () {
    expect(ResolveAppLocaleFromCode.call('xx'), AppLocale.en);
  });

  test('falls back to English for null', () {
    expect(ResolveAppLocaleFromCode.call(null), AppLocale.en);
  });
}
