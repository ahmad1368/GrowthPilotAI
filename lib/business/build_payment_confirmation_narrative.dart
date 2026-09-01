import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';

/// Merchant-facing confirmation shown the instant a payment is
/// processed (Issue #410, acceptance criterion 5) — this app has no
/// email/push backend, so the alert surfaces directly in the
/// dashboard instead of a dispatched notification.
class BuildPaymentConfirmationNarrative {
  static String call(AdvertisingRequestEntity request, PaymentVerificationStatus status) {
    if (status == PaymentVerificationStatus.verified) {
      return 'Payment verified — ${request.merchantName}\'s ${request.packageType.name} '
          'campaign is now live.';
    }
    return 'Payment for ${request.merchantName} could not be verified; campaign not activated.';
  }
}
