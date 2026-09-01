import 'package:growth_pilot_ai/business/default_role_permissions.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/permission.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

/// Granular permission check (Issue #174) — the client-side equivalent of
/// a NestJS `@Permissions()` guard, since this app has no backend to
/// enforce it server-side (see docs/adr/0004). Owner always passes (AC:
/// "Admin Exception"); everyone else needs the scope in their role's
/// defaults or their [Membership.customPermissions].
class HasPermission {
  static bool call(List<Membership> memberships, String businessId, Permission permission) {
    Membership? active;
    for (final m in memberships) {
      if (m.isActive && m.businessId == businessId) {
        active = m;
        break;
      }
    }
    if (active == null) return false;
    if (active.role == MembershipRole.owner) return true;

    return DefaultRolePermissions.forRole(active.role).contains(permission) ||
        active.customPermissions.contains(permission);
  }
}
