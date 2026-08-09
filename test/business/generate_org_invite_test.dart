import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_org_invite.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  test('generates a 32-char token and 48h expiry', () {
    final invite = GenerateOrgInvite.call(
        'biz-a', 'new@team.com', MembershipRole.buyer, now,
        random: Random(1));

    expect(invite.token.length, 32);
    expect(invite.businessId, 'biz-a');
    expect(invite.invitedEmail, 'new@team.com');
    expect(invite.role, MembershipRole.buyer);
    expect(invite.expiresAt, now.add(const Duration(hours: 48)));
    expect(invite.redeemed, isFalse);
  });

  test('tokens differ across calls', () {
    final a = GenerateOrgInvite.call('biz-a', 'x@y.com', MembershipRole.buyer, now);
    final b = GenerateOrgInvite.call('biz-a', 'x@y.com', MembershipRole.buyer, now);
    expect(a.token, isNot(b.token));
  });
}
