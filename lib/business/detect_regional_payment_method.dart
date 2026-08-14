import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Suggests the most relevant regional payment rail for a currency
/// (Issue #422, acceptance criteria 1-2) — this app has no real
/// geolocation/user-profile detection, so routing is a currency-code
/// lookup rather than device geolocation; the merchant can still
/// override the suggestion by picking a different provider.
class DetectRegionalPaymentMethod {
  static BankingGatewayProvider call(String currency) {
    return switch (currency.toUpperCase()) {
      'CAD' => BankingGatewayProvider.interac,
      'CNY' => BankingGatewayProvider.unionPay,
      'USD' || 'EUR' || 'GBP' || 'AUD' || 'AED' => BankingGatewayProvider.localNetwork,
      _ => BankingGatewayProvider.stripe,
    };
  }
}
