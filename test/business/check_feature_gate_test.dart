import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/check_feature_gate.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

void main() {
  test('a tier can access a feature that requires its own tier', () {
    expect(
        CheckFeatureGate.call(
            currentTier: SubscriptionTier.pro, requiredTier: SubscriptionTier.pro),
        isTrue);
  });

  test('a higher tier can access a lower-tier feature', () {
    expect(
        CheckFeatureGate.call(
            currentTier: SubscriptionTier.enterprise, requiredTier: SubscriptionTier.pro),
        isTrue);
  });

  test('a lower tier cannot access a higher-tier feature', () {
    expect(
        CheckFeatureGate.call(
            currentTier: SubscriptionTier.starter, requiredTier: SubscriptionTier.pro),
        isFalse);
  });
}
