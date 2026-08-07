import 'package:growth_pilot_ai/core/enum/banking_gateway_provider.dart';

/// Picks a fallback rail when a regional gateway times out or is
/// unavailable (Issue #422, acceptance criterion 3) — this app has
/// no real outage-detection feed, so failures are merchant-reported
/// (via [FailGatewayTransaction]) rather than auto-detected; Stripe
/// is the universal fallback since it's the only rail with no
/// regional restriction.
class RouteGatewayFallback {
  static BankingGatewayProvider call(BankingGatewayProvider failedProvider) {
    return failedProvider == BankingGatewayProvider.stripe
        ? BankingGatewayProvider.paypal
        : BankingGatewayProvider.stripe;
  }
}
