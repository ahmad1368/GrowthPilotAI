import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_founding_member_premium.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

void main() {
  group('ApplyFoundingMemberPremium', () {
    test('upgrades to Pro, marks active, and extends 6 months out (Issue #191 AC)', () {
      final now = DateTime(2026, 1, 1);
      final subscription = SubscriptionEntity(
        businessId: 'b1',
        dbTier: SubscriptionTier.starter.index,
        dbStatus: SubscriptionStatus.canceled.index,
        currentPeriodEnd: now,
        createdAt: now,
      );

      ApplyFoundingMemberPremium.call(subscription, now);

      expect(subscription.tier, SubscriptionTier.pro);
      expect(subscription.status, SubscriptionStatus.active);
      expect(subscription.currentPeriodEnd, now.add(ApplyFoundingMemberPremium.sixMonths));
    });
  });
}
