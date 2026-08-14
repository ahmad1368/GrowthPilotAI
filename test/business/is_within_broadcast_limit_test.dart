import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_within_broadcast_limit.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

void main() {
  test('starter is blocked once its monthly quota is reached', () {
    expect(
        IsWithinBroadcastLimit.call(tier: SubscriptionTier.starter, currentMonthCount: 3),
        isFalse);
  });

  test('starter is allowed below its monthly quota', () {
    expect(
        IsWithinBroadcastLimit.call(tier: SubscriptionTier.starter, currentMonthCount: 2),
        isTrue);
  });

  test('enterprise has no limit', () {
    expect(
        IsWithinBroadcastLimit.call(tier: SubscriptionTier.enterprise, currentMonthCount: 9999),
        isTrue);
  });
}
