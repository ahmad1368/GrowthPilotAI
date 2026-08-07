import 'package:growth_pilot_ai/business/is_referral_expired.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_reward_entity.dart';
import 'package:growth_pilot_ai/core/enum/referral_invite_status.dart';
import 'package:growth_pilot_ai/core/enum/referral_recipient_role.dart';

/// Validates and redeems a referral invite, granting the double-sided
/// reward to both parties (Issue #542, acceptance criteria 4-5) —
/// returns null if the code has expired, since an expired code can
/// never be redeemed regardless of its stored status.
class RedeemReferralInvite {
  static const rewardPercent = 10.0;

  static ({ReferralInviteEntity invite, List<ReferralRewardEntity> rewards})? call(
    ReferralInviteEntity invite,
    DateTime now,
  ) {
    if (IsReferralExpired.call(invite.expiresAt, now)) return null;
    invite.status = ReferralInviteStatus.redeemed;

    final rewards = [
      ReferralRewardEntity(referralInviteId: invite.id, rewardPercent: rewardPercent, grantedAt: now)
        ..recipientRole = ReferralRecipientRole.inviter,
      ReferralRewardEntity(referralInviteId: invite.id, rewardPercent: rewardPercent, grantedAt: now)
        ..recipientRole = ReferralRecipientRole.invitee,
    ];
    return (invite: invite, rewards: rewards);
  }
}
