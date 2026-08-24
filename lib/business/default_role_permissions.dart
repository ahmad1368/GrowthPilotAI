import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/permission.dart';

/// The baseline permission set each [MembershipRole] carries before any
/// additive [Membership.customPermissions] grants (Issue #174). Owner is
/// handled separately as a wildcard by [HasPermission] — see AC "Admin
/// Exception" — so it isn't enumerated here.
class DefaultRolePermissions {
  static Set<Permission> forRole(MembershipRole role) => switch (role) {
        MembershipRole.owner => Permission.values.toSet(),
        MembershipRole.admin => {
            Permission.viewReports,
            Permission.manageInventory,
            Permission.manageChat,
          },
        MembershipRole.buyer => {Permission.manageChat},
        MembershipRole.vendor => {Permission.manageChat},
      };
}
