import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redeem_referral_invite.dart';
import 'package:growth_pilot_ai/core/data/entities/referral_invite_entity.dart';
import 'package:growth_pilot_ai/core/enum/referral_invite_status.dart';
import 'package:growth_pilot_ai/core/enum/referral_recipient_role.dart';

ReferralInviteEntity _invite(DateTime expiresAt) {
  return ReferralInviteEntity(
    id: 5,
    inviterName: 'Alpha',
    contactIdentifier: 'beta@example.com',
    referralCode: 'ABC12345',
    issuedAt: DateTime(2026, 1, 1),
    expiresAt: expiresAt,
  );
}

void main() {
  test('grants a matching reward to both inviter and invitee', () {
    final result = RedeemReferralInvite.call(_invite(DateTime(2026, 1, 8)), DateTime(2026, 1, 5));
    expect(result, isNotNull);
    expect(result!.invite.status, ReferralInviteStatus.redeemed);
    expect(result.rewards.length, 2);
    expect(result.rewards.map((r) => r.recipientRole),
        containsAll([ReferralRecipientRole.inviter, ReferralRecipientRole.invitee]));
    expect(result.rewards.every((r) => r.rewardPercent == 10.0), true);
  });

  test('refuses to redeem an expired invite', () {
    final result = RedeemReferralInvite.call(_invite(DateTime(2026, 1, 8)), DateTime(2026, 1, 9));
    expect(result, isNull);
  });
}
