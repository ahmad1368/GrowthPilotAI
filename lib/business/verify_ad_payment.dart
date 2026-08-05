import 'package:growth_pilot_ai/business/compute_ad_package_price.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';

/// Matches a captured payment against the requesting merchant's
/// package SKU price (Issue #410, acceptance criterion 2) — the
/// captured amount must cover the full SKU price for the specific
/// request it references to verify; anything less fails, same as a
/// real gateway would reject a partial settlement.
class VerifyAdPayment {
  static PaymentVerificationStatus call({
    required AdvertisingRequestEntity request,
    required double amountPaid,
  }) {
    final price = ComputeAdPackagePrice.call(request.packageType);
    return amountPaid >= price
        ? PaymentVerificationStatus.verified
        : PaymentVerificationStatus.failed;
  }
}
