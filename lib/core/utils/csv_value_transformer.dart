import 'package:growth_pilot_ai/core/utils/currency_format.dart';

/// Turns raw cell values into human-readable strings and applies RFC-4180 CSV
/// escaping. Currency (double) → CAD, DateTime → local ISO date, bool → Yes/No.
class CsvValueTransformer {
  static String format(dynamic value) {
    if (value == null) return '';
    if (value is double) return CurrencyFormat.cad(value);
    if (value is DateTime) return value.toLocal().toIso8601String().split('T').first;
    if (value is bool) return value ? 'Yes' : 'No';
    return value.toString();
  }

  /// Wraps a cell in quotes (escaping embedded quotes) if it contains a comma,
  /// quote, or newline — otherwise returns it unchanged.
  static String escape(String cell) {
    if (cell.contains(RegExp('[",\n]'))) {
      return '"${cell.replaceAll('"', '""')}"';
    }
    return cell;
  }
}
