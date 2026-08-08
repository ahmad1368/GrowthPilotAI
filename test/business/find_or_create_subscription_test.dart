import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/find_or_create_subscription.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  test('creates a free starter row when none exists', () {
    final sub = FindOrCreateSubscription.call(null, 'biz-1', now);
    expect(sub.tier, SubscriptionTier.starter);
    expect(sub.businessId, 'biz-1');
  });

  test('reuses the existing subscription for that business', () {
    final existing = SubscriptionEntity(businessId: 'biz-1', currentPeriodEnd: now, createdAt: now);
    final sub = FindOrCreateSubscription.call(existing, 'biz-1', now);
    expect(identical(sub, existing), isTrue);
  });
}
