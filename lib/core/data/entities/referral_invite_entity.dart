import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/referral_channel.dart';
import 'package:growth_pilot_ai/core/enum/referral_invite_status.dart';

/// One trackable referral code issued to a non-registered contact
/// (Issue #542, acceptance criteria 2 and 5).
@Entity()
class ReferralInviteEntity {
  @Id()
  int id = 0;

  String inviterName;

  @Index()
  String contactIdentifier;

  @Index()
  String referralCode;

  int dbChannel;
  int dbStatus;

  @Property(type: PropertyType.date)
  DateTime issuedAt;

  @Property(type: PropertyType.date)
  DateTime expiresAt;

  ReferralInviteEntity({
    this.id = 0,
    required this.inviterName,
    required this.contactIdentifier,
    required this.referralCode,
    this.dbChannel = 0,
    this.dbStatus = 0,
    required this.issuedAt,
    required this.expiresAt,
  });

  ReferralChannel get channel => ReferralChannel.values[dbChannel];
  set channel(ReferralChannel value) => dbChannel = value.index;

  ReferralInviteStatus get status => ReferralInviteStatus.values[dbStatus];
  set status(ReferralInviteStatus value) => dbStatus = value.index;
}
