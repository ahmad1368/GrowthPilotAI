import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/membership_resolver.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

Membership _m(String biz, MembershipRole role, MembershipStatus status) =>
    Membership(userId: 'u1', businessId: biz, role: role, status: status);

void main() {
  final memberships = [
    _m('biz-a', MembershipRole.owner, MembershipStatus.active),
    _m('biz-b', MembershipRole.buyer, MembershipStatus.active),
    _m('biz-c', MembershipRole.admin, MembershipStatus.pending),
    _m('biz-d', MembershipRole.vendor, MembershipStatus.revoked),
  ];

  test('accessibleBusinessIds includes only active memberships', () {
    expect(MembershipResolver.accessibleBusinessIds(memberships).toSet(),
        {'biz-a', 'biz-b'});
  });

  test('activeRole returns the role for an active tenant', () {
    expect(MembershipResolver.activeRole(memberships, 'biz-a'),
        MembershipRole.owner);
  });

  test('activeRole is null for pending/revoked/unknown tenants', () {
    expect(MembershipResolver.activeRole(memberships, 'biz-c'), isNull);
    expect(MembershipResolver.activeRole(memberships, 'biz-d'), isNull);
    expect(MembershipResolver.activeRole(memberships, 'biz-x'), isNull);
  });

  test('hasAccess reflects active membership only', () {
    expect(MembershipResolver.hasAccess(memberships, 'biz-b'), isTrue);
    expect(MembershipResolver.hasAccess(memberships, 'biz-c'), isFalse);
  });
}
