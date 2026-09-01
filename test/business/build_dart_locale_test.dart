import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_dart_locale.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

void main() {
  test('converts an AppLocale to its dart:ui Locale', () {
    expect(BuildDartLocale.call(AppLocale.fr), const Locale('fr'));
    expect(BuildDartLocale.call(AppLocale.zhHans), const Locale('zh'));
  });
}
