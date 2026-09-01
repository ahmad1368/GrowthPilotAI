/// Converts a foreign-currency amount into the merchant's CAD base
/// currency (Issue #421, acceptance criterion 2; crypto/stablecoin
/// rates added for Issue #423) — this app has no live forex/crypto
/// price feed, so rates are a static local table rather than
/// real-time market data; unknown currencies default to parity (rate
/// 1.0) rather than failing the transaction. Called once at
/// authorization and never recomputed afterward, this table's rate
/// is what structurally "locks" the conversion rate for the
/// transaction's checkout window (Issue #423, acceptance criterion
/// 3) — there's no separate lock/unlock step to model.
class ComputeExchangeConversion {
  static const ratesToCad = {
    'CAD': 1.0,
    'USD': 1.35,
    'EUR': 1.47,
    'GBP': 1.72,
    'AUD': 0.90,
    'CNY': 0.19,
    'AED': 0.37,
    'USDT': 1.35, // pegged to USD
    'USDC': 1.35, // pegged to USD
    'BTC': 121000.0, // illustrative, not live market data
    'ETH': 4500.0, // illustrative, not live market data
  };

  static ({double convertedAmount, double exchangeRate}) call(double amount, String currency) {
    final rate = ratesToCad[currency.toUpperCase()] ?? 1.0;
    return (convertedAmount: amount * rate, exchangeRate: rate);
  }
}
