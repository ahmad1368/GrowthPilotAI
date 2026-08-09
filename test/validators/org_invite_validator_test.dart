import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/models/org_invite.dart';
import 'package:growth_pilot_ai/validators/org_invite_validator.dart';

void main() {
  final now = DateTime(2026, 1, 3);
  OrgInvite invite({bool redeemed = false, Duration ttl = const Duration(hours: 48)}) =>
      OrgInvite(
        token: 't1',
        businessId: 'biz-a',
        invitedEmail: 'a@b.com',
        role: MembershipRole.buyer,
        createdAt: now.subtract(const Duration(hours: 1)),
        expiresAt: now.subtract(const Duration(hours: 1)).add(ttl),
        redeemed: redeemed,
      );

  test('valid, unexpired, unredeemed invite is redeemable', () {
    expect(OrgInviteValidator.isRedeemable(invite(), now), isTrue);
    expect(OrgInviteValidator.rejectionReason(invite(), now), isNull);
  });

  test('expired invite is rejected', () {
    final expired = invite(ttl: const Duration(minutes: 30));
    expect(OrgInviteValidator.isRedeemable(expired, now), isFalse);
    expect(OrgInviteValidator.rejectionReason(expired, now), contains('expired'));
  });

  test('already-redeemed invite is rejected', () {
    final used = invite(redeemed: true);
    expect(OrgInviteValidator.isRedeemable(used, now), isFalse);
    expect(OrgInviteValidator.rejectionReason(used, now), contains('already used'));
  });
}
