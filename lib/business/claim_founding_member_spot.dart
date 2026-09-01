import 'package:growth_pilot_ai/business/apply_founding_member_premium.dart';
import 'package:growth_pilot_ai/business/find_or_create_subscription.dart';
import 'package:growth_pilot_ai/business/should_grant_founding_member_spot.dart';
import 'package:growth_pilot_ai/core/data/entities/founding_member_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/founding_member_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/subscription_repository.dart';

/// "First 100 successful registrations" get a Founding Member badge +
/// 6 months free Premium (Issue #191) — [foundingRepo]'s counter is
/// local-only per install, not a true cross-user global count (no
/// shared backend exists in this repo; see PR notes). Returns the
/// existing spot if [businessId] already claimed one, null if the
/// program is full (Issue #191 AC), or the newly-claimed spot.
class ClaimFoundingMemberSpot {
  static FoundingMemberEntity? call({
    required FoundingMemberRepository foundingRepo,
    required SubscriptionRepository subscriptionRepo,
    required String businessId,
    required DateTime now,
    String? acquisitionSource,
    String? acquisitionCampaign,
  }) {
    final existing = foundingRepo.getForBusiness(businessId);
    if (existing != null) return existing;

    final counter = foundingRepo.getCounter();
    if (!ShouldGrantFoundingMemberSpot.call(claimedCount: counter.claimedCount, capacity: counter.capacity)) {
      return null;
    }

    final spot = FoundingMemberEntity(
      businessId: businessId,
      spotNumber: counter.claimedCount + 1,
      claimedAt: now,
      acquisitionSource: acquisitionSource,
      acquisitionCampaign: acquisitionCampaign,
    );
    foundingRepo.incrementCounter();
    foundingRepo.saveMember(spot);

    final subscription = FindOrCreateSubscription.call(subscriptionRepo.getForBusiness(businessId), businessId, now);
    ApplyFoundingMemberPremium.call(subscription, now);
    subscriptionRepo.upsert(subscription);

    return spot;
  }
}
