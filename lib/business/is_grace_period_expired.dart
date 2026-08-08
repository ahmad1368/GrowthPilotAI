import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';

/// Pairs with [ApplyGracePeriod] — true once the 48h window has passed
/// without a successful renewal, at which point a `pastDue`
/// subscription is treated as `canceled`.
class IsGracePeriodExpired {
  static bool call(SubscriptionEntity subscription, DateTime now) {
    if (subscription.status != SubscriptionStatus.pastDue) return false;
    final endsAt = subscription.gracePeriodEndsAt;
    return endsAt != null && now.isAfter(endsAt);
  }
}
