import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_subscription_renewal_charge.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

void main() {
  test('starter renewal is free with no tax', () {
    final charge =
        ComputeSubscriptionRenewalCharge.call(SubscriptionTier.starter, applyPst: true);
    expect(charge.total, 0);
  });

  test('pro renewal applies GST and PST on top of the monthly price', () {
    final charge = ComputeSubscriptionRenewalCharge.call(SubscriptionTier.pro, applyPst: true);
    expect(charge.subtotal, 29.99);
    expect(charge.total, closeTo(29.99 + 29.99 * 0.05 + 29.99 * 0.07, 0.01));
  });

  test('a PST-exempt province only applies GST', () {
    final charge = ComputeSubscriptionRenewalCharge.call(SubscriptionTier.pro, applyPst: false);
    expect(charge.tax.pst, 0);
  });
}
