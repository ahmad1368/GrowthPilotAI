import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redeem_org_invite.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/models/org_invite.dart';

void main() {
  final now = DateTime(2026, 1, 1);
  final invite = OrgInvite(
    token: 't1',
    businessId: 'biz-a',
    invitedEmail: 'a@b.com',
    role: MembershipRole.admin,
    createdAt: now,
    expiresAt: now.add(const Duration(hours: 48)),
  );

  test('redeems a valid invite into an active membership', () async {
    final result = await RedeemOrgInvite.call(invite, 'user-1', now);

    expect(result.success, isTrue);
    expect(result.data?.userId, 'user-1');
    expect(result.data?.businessId, 'biz-a');
    expect(result.data?.role, MembershipRole.admin);
    expect(result.data?.status, MembershipStatus.active);
  });

  test('rejects an expired invite', () async {
    final result = await RedeemOrgInvite.call(
        invite, 'user-1', now.add(const Duration(hours: 49)));

    expect(result.success, isFalse);
    expect(result.statusCode, 403);
  });

  test('rejects an already-redeemed invite', () async {
    final result = await RedeemOrgInvite.call(invite.markRedeemed(), 'user-1', now);

    expect(result.success, isFalse);
  });
}
