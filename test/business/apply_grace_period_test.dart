import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/apply_grace_period.dart';
import 'package:growth_pilot_ai/business/is_grace_period_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';

void main() {
  final now = DateTime(2026, 1, 1);

  SubscriptionEntity subscription() =>
      SubscriptionEntity(businessId: 'biz-1', currentPeriodEnd: now, createdAt: now);

  test('opens a 48h grace window on a failed renewal', () {
    final sub = subscription();
    ApplyGracePeriod.call(sub, now);

    expect(sub.status, SubscriptionStatus.pastDue);
    expect(sub.gracePeriodEndsAt, now.add(const Duration(hours: 48)));
  });

  test('grace period is not yet expired right after opening', () {
    final sub = subscription();
    ApplyGracePeriod.call(sub, now);

    expect(IsGracePeriodExpired.call(sub, now.add(const Duration(hours: 1))), isFalse);
  });

  test('grace period is expired once 48h have passed', () {
    final sub = subscription();
    ApplyGracePeriod.call(sub, now);

    expect(IsGracePeriodExpired.call(sub, now.add(const Duration(hours: 49))), isTrue);
  });

  test('an active subscription is never "expired"', () {
    final sub = subscription();
    expect(IsGracePeriodExpired.call(sub, now.add(const Duration(days: 10))), isFalse);
  });
}
