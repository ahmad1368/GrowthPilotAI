/// Converts a foreign-currency amount into the merchant's CAD base
/// currency (Issue #421, acceptance criterion 2) — this app has no
/// live forex-feed subscription, so rates are a static local table
/// rather than real-time market data; unknown currencies default to
/// parity (rate 1.0) rather than failing the transaction.
class ComputeExchangeConversion {
  static const ratesToCad = {
    'CAD': 1.0,
    'USD': 1.35,
    'EUR': 1.47,
    'GBP': 1.72,
    'AUD': 0.90,
    'CNY': 0.19,
    'AED': 0.37,
  };

  static ({double convertedAmount, double exchangeRate}) call(double amount, String currency) {
    final rate = ratesToCad[currency.toUpperCase()] ?? 1.0;
    return (convertedAmount: amount * rate, exchangeRate: rate);
  }
}
