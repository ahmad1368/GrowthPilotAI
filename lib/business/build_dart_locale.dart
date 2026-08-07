import 'package:flutter/widgets.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// Converts an [AppLocale] to the `dart:ui` [Locale] Flutter's
/// localization/RTL machinery expects (Issue #429, acceptance
/// criterion 3).
class BuildDartLocale {
  static Locale call(AppLocale locale) => Locale(locale.languageCode);
}
