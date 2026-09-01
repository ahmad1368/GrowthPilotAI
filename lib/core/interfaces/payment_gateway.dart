import 'package:growth_pilot_ai/core/models/omni_response.dart';

/// "Payment Intent API" contract (Issue #147) — a real implementation
/// would call Stripe; this app has no Stripe account or PCI-compliant
/// infrastructure to collect card data with, so [MockPaymentGateway]
/// simulates the intent lifecycle instead of ever touching real funds.
abstract class PaymentGateway {
  /// Resolves to a fake "client secret"/intent id.
  OmniResult<String> createPaymentIntent({required double amount, required String currency});

  OmniResult<bool> confirmPayment(String intentId);
}
