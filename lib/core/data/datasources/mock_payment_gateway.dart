import 'package:growth_pilot_ai/core/interfaces/payment_gateway.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Local stand-in for Stripe (Issue #147) — no real card data is ever
/// collected; this always "succeeds" to exercise the rest of the
/// payment lifecycle without a real payment processor.
class MockPaymentGateway implements PaymentGateway {
  @override
  OmniResult<String> createPaymentIntent({required double amount, required String currency}) async {
    final intentId = 'mock-intent-${DateTime.now().microsecondsSinceEpoch}';
    OmniLogger.info('Created payment intent $intentId for $amount $currency');
    return OmniResponse.success(intentId);
  }

  @override
  OmniResult<bool> confirmPayment(String intentId) async {
    OmniLogger.info('Confirmed payment intent $intentId');
    return OmniResponse.success(true);
  }
}
