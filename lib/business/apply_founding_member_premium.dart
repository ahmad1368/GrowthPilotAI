import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/enum/subscription_status.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// "Automatically set isPremium and subscriptionExpiry to CurrentDate
/// + 6 Months" (Issue #191) — maps "Premium" to this repo's existing
/// #150 Pro tier (no separate isPremium flag exists; Pro is already
/// the paid tier feature-gated code checks against).
class ApplyFoundingMemberPremium {
  static const sixMonths = Duration(days: 182);

  static void call(SubscriptionEntity subscription, DateTime now) {
    subscription.tier = SubscriptionTier.pro;
    subscription.status = SubscriptionStatus.active;
    subscription.currentPeriodEnd = now.add(sixMonths);
  }
}
