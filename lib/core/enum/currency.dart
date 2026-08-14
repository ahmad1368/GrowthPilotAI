/// Supported settlement currencies (Issue #153).
enum Currency { cad, usd, eur }

extension CurrencyCode on Currency {
  String get code => name.toUpperCase();
}
