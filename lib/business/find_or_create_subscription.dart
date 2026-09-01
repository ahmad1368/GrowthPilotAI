import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';

/// Every business implicitly starts on the free [SubscriptionTier.starter]
/// tier (Issue #150) — this returns that default row instead of the
/// caller having to special-case "no subscription yet" everywhere.
class FindOrCreateSubscription {
  static SubscriptionEntity call(SubscriptionEntity? existing, String businessId, DateTime now) {
    return existing ??
        SubscriptionEntity(
            businessId: businessId,
            currentPeriodEnd: now.add(const Duration(days: 30)),
            createdAt: now);
  }
}
