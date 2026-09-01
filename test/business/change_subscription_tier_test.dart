import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/change_subscription_tier.dart';
import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

class _FakeSubscriptionRepository implements SubscriptionRepository {
  final subscriptions = <String, SubscriptionEntity>{};

  @override
  SubscriptionEntity? getForBusiness(String businessId) => subscriptions[businessId];

  @override
  int upsert(SubscriptionEntity subscription) {
    subscriptions[subscription.businessId] = subscription;
    return 1;
  }
}

void main() {
  group('ChangeSubscriptionTier', () {
    test('updates the tier and persists it (Issue #171)', () {
      final repository = _FakeSubscriptionRepository();
      final subscription = SubscriptionEntity(
        businessId: 'b1',
        dbTier: SubscriptionTier.starter.index,
        currentPeriodEnd: DateTime(2026, 2, 1),
        createdAt: DateTime(2026, 1, 1),
      );

      ChangeSubscriptionTier.call(repository, subscription, SubscriptionTier.pro);

      expect(subscription.tier, SubscriptionTier.pro);
      expect(repository.subscriptions['b1']!.tier, SubscriptionTier.pro);
    });
  });
}
