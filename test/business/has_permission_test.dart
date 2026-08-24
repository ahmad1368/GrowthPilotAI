import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/has_permission.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/enum/permission.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

Membership _m({
  required MembershipRole role,
  MembershipStatus status = MembershipStatus.active,
  Set<Permission> customPermissions = const {},
}) =>
    Membership(userId: 'u1', businessId: 'biz-a', role: role, status: status, customPermissions: customPermissions);

void main() {
  group('HasPermission (Issue #174)', () {
    test('owner always passes, even for a permission not in the default set', () {
      final memberships = [_m(role: MembershipRole.owner)];
      expect(HasPermission.call(memberships, 'biz-a', Permission.manageTeam), isTrue);
    });

    test('admin passes for a permission in their default set', () {
      final memberships = [_m(role: MembershipRole.admin)];
      expect(HasPermission.call(memberships, 'biz-a', Permission.viewReports), isTrue);
    });

    test('admin fails for a permission outside their default set', () {
      final memberships = [_m(role: MembershipRole.admin)];
      expect(HasPermission.call(memberships, 'biz-a', Permission.manageBilling), isFalse);
    });

    test('additive grant: a buyer with a custom permission passes for it (AC: Granularity)', () {
      final memberships = [_m(role: MembershipRole.buyer, customPermissions: {Permission.viewReports})];
      expect(HasPermission.call(memberships, 'biz-a', Permission.viewReports), isTrue);
    });

    test('a buyer without the custom grant still fails for it', () {
      final memberships = [_m(role: MembershipRole.buyer)];
      expect(HasPermission.call(memberships, 'biz-a', Permission.viewReports), isFalse);
    });

    test('no active membership in the business fails closed', () {
      final memberships = [_m(role: MembershipRole.owner, status: MembershipStatus.revoked)];
      expect(HasPermission.call(memberships, 'biz-a', Permission.manageChat), isFalse);
    });

    test('no membership at all fails closed', () {
      expect(HasPermission.call([], 'biz-a', Permission.manageChat), isFalse);
    });
  });
}
