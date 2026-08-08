/// "The Currency Conversion Utility" (Issue #153) — applies the same
/// 0.5% platform buffer for exchange-rate slippage the issue's own
/// `CurrencyConverterService` spec calls for.
class ConvertCurrency {
  static const platformBuffer = 1.005;

  static double call(double amount, double rate) {
    return double.parse((amount * rate * platformBuffer).toStringAsFixed(2));
  }
}
