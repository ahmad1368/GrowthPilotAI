import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_ad_package_price.dart';
import 'package:growth_pilot_ai/business/verify_ad_payment.dart';
import 'package:growth_pilot_ai/core/data/entities/advertising_request_entity.dart';
import 'package:growth_pilot_ai/core/enum/ad_package_type.dart';
import 'package:growth_pilot_ai/core/enum/payment_verification_status.dart';

AdvertisingRequestEntity _request(AdPackageType type) => AdvertisingRequestEntity(
      merchantName: 'Test Merchant',
      category: 'Retail',
      dbPackageType: type.index,
      requestedAt: DateTime(2026, 1, 1),
    );

void main() {
  test('an amount matching the SKU price verifies', () {
    final request = _request(AdPackageType.featuredSlot);
    final price = ComputeAdPackagePrice.call(AdPackageType.featuredSlot);

    final result = VerifyAdPayment.call(request: request, amountPaid: price);

    expect(result, PaymentVerificationStatus.verified);
  });

  test('an amount above the SKU price still verifies', () {
    final request = _request(AdPackageType.featuredSlot);
    final price = ComputeAdPackagePrice.call(AdPackageType.featuredSlot);

    final result = VerifyAdPayment.call(request: request, amountPaid: price + 50);

    expect(result, PaymentVerificationStatus.verified);
  });

  test('a partial payment below the SKU price fails verification', () {
    final request = _request(AdPackageType.homepageBanner);
    final price = ComputeAdPackagePrice.call(AdPackageType.homepageBanner);

    final result = VerifyAdPayment.call(request: request, amountPaid: price / 2);

    expect(result, PaymentVerificationStatus.failed);
  });
}
