import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';

/// "48-hour grace period before Verified Status is impacted" (Issue
/// #150 AC) — a failed renewal marks the subscription `pastDue` and
/// opens a 48h window; it does NOT immediately affect anything else.
/// Wiring [IsGracePeriodExpired] into #144's Verified Status / #125's
/// trust score is left as a follow-up so this issue doesn't have to
/// change either of those pre-existing signatures.
class ApplyGracePeriod {
  static const graceWindow = Duration(hours: 48);

  static SubscriptionEntity call(SubscriptionEntity subscription, DateTime now) {
    if (subscription.status != SubscriptionStatus.pastDue) {
      subscription.status = SubscriptionStatus.pastDue;
      subscription.gracePeriodEndsAt = now.add(graceWindow);
    }
    return subscription;
  }
}
