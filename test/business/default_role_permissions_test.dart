import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/default_role_permissions.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/permission.dart';

void main() {
  group('DefaultRolePermissions (Issue #174)', () {
    test('owner gets every permission (AC: Admin Exception wildcard)', () {
      expect(DefaultRolePermissions.forRole(MembershipRole.owner), Permission.values.toSet());
    });

    test('admin gets management scopes but not billing/team', () {
      final perms = DefaultRolePermissions.forRole(MembershipRole.admin);
      expect(perms.contains(Permission.viewReports), isTrue);
      expect(perms.contains(Permission.manageInventory), isTrue);
      expect(perms.contains(Permission.manageBilling), isFalse);
      expect(perms.contains(Permission.manageTeam), isFalse);
    });

    test('buyer and vendor default to chat only', () {
      expect(DefaultRolePermissions.forRole(MembershipRole.buyer), {Permission.manageChat});
      expect(DefaultRolePermissions.forRole(MembershipRole.vendor), {Permission.manageChat});
    });
  });
}
