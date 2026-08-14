import 'package:growth_pilot_ai/business/build_referral_invite_message.dart';
import 'package:growth_pilot_ai/business/compute_referral_expiry.dart';
import 'package:growth_pilot_ai/business/generate_referral_code.dart';
import 'package:growth_pilot_ai/business/redeem_referral_invite.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_dispatch.dart';
import 'package:growth_pilot_ai/features/referrals/widgets/referral_repos.dart';

/// Referral-code generation, invite dispatch, and redemption (Issue
/// #542, acceptance criteria 2-6) — split out of [ReferralBody].
class ReferralActions {
  static const appName = 'GrowthPilot AI';
  final ReferralRepos repos;

  ReferralActions(this.repos);

  ReferralInviteEntity getOrCreateInvite(String inviterName, String contactIdentifier) {
    final existing = repos.invites.forContact(contactIdentifier);
    if (existing != null) return existing;

    final now = DateTime.now();
    final invite = ReferralInviteEntity(
      inviterName: inviterName,
      contactIdentifier: contactIdentifier,
      referralCode: GenerateReferralCode.call(inviterName, contactIdentifier, now),
      issuedAt: now,
      expiresAt: ComputeReferralExpiry.call(now),
    );
    invite.id = repos.invites.save(invite);
    return invite;
  }

  Future<void> dispatch(ReferralInviteEntity invite, ReferralChannel channel) async {
    final message = BuildReferralInviteMessage.call(appName, invite.referralCode, invite.expiresAt);
    await dispatchReferralInvite(channel, invite.contactIdentifier, appName, message);
    invite.channel = channel;
    repos.invites.save(invite);
  }

  bool redeem(ReferralInviteEntity invite) {
    final result = RedeemReferralInvite.call(invite, DateTime.now());
    if (result == null) return false;
    repos.invites.save(result.invite);
    for (final reward in result.rewards) {
      repos.rewards.record(reward);
    }
    return true;
  }
}
