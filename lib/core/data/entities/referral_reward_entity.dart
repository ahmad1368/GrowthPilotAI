import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/referral_recipient_role.dart';

/// One granted double-sided referral reward (Issue #542, acceptance
/// criterion 4) — always issued in inviter/invitee pairs by
/// [RedeemReferralInvite].
@Entity()
class ReferralRewardEntity {
  @Id()
  int id = 0;

  @Index()
  int referralInviteId;

  int dbRecipientRole;
  double rewardPercent;

  @Property(type: PropertyType.date)
  DateTime grantedAt;

  ReferralRewardEntity({
    this.id = 0,
    required this.referralInviteId,
    this.dbRecipientRole = 0,
    required this.rewardPercent,
    required this.grantedAt,
  });

  ReferralRecipientRole get recipientRole => ReferralRecipientRole.values[dbRecipientRole];
  set recipientRole(ReferralRecipientRole value) => dbRecipientRole = value.index;
}
