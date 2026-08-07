import 'package:intl/intl.dart';
import 'package:growth_pilot_ai/core/enum/app_locale.dart';

/// Locale-aware currency/number/date formatting (Issue #429, acceptance
/// criterion 4) — a thin `intl` wrapper keyed by the active
/// [AppLocale]; existing CAD-only call sites (CSV exports, accounting
/// reports) keep using [CurrencyFormat] unchanged.
class LocaleNumberFormat {
  static String currency(double amount, AppLocale locale, {String currencyCode = 'CAD'}) {
    return NumberFormat.currency(locale: locale.languageCode, name: currencyCode).format(amount);
  }

  static String decimal(double amount, AppLocale locale) =>
      NumberFormat.decimalPattern(locale.languageCode).format(amount);

  static String date(DateTime date, AppLocale locale) =>
      DateFormat.yMMMd(locale.languageCode).format(date);
}
