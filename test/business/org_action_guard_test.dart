import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/org_action_guard.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

Membership _m(MembershipRole role) => Membership(
    userId: 'u1', businessId: 'biz-a', role: role, status: MembershipStatus.active);

void main() {
  test('owner and admin can approve any amount', () {
    expect(OrgActionGuard.canApprovePayment([_m(MembershipRole.owner)], 'biz-a', 50000), isTrue);
    expect(OrgActionGuard.canApprovePayment([_m(MembershipRole.admin)], 'biz-a', 50000), isTrue);
  });

  test('buyer is capped at the approval limit', () {
    final memberships = [_m(MembershipRole.buyer)];
    expect(OrgActionGuard.canApprovePayment(memberships, 'biz-a', 1000), isTrue);
    expect(OrgActionGuard.canApprovePayment(memberships, 'biz-a', 1000.01), isFalse);
  });

  test('vendor can never approve payments', () {
    expect(OrgActionGuard.canApprovePayment([_m(MembershipRole.vendor)], 'biz-a', 1), isFalse);
  });

  test('no active membership in the business denies the action', () {
    expect(OrgActionGuard.canApprovePayment([_m(MembershipRole.owner)], 'biz-b', 1), isFalse);
  });
}
