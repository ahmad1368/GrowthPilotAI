import 'package:growth_pilot_ai/core/data/entities/subscription_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';
import 'package:growth_pilot_ai/core/enum/subscription_tier.dart';

/// The local, native-UI equivalent of Issue #171's Stripe Customer
/// Portal "switch from Basic to Pro" step — the next renewal simply
/// bills at the new tier's rate via the existing
/// `ComputeSubscriptionRenewalCharge` (no Stripe account exists in
/// this repo; see PR notes).
class ChangeSubscriptionTier {
  static void call(SubscriptionRepository repository, SubscriptionEntity subscription, SubscriptionTier newTier) {
    subscription.tier = newTier;
    repository.upsert(subscription);
  }
}
