import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

/// Client-side tenant-isolation logic: decides which businesses an identity can
/// act in and with what role, honoring that only ACTIVE memberships grant
/// access (PENDING/REVOKED are ignored).
class MembershipResolver {
  /// Distinct business ids the user has active access to.
  static List<String> accessibleBusinessIds(List<Membership> memberships) =>
      memberships
          .where((m) => m.isActive)
          .map((m) => m.businessId)
          .toSet()
          .toList();

  /// The user's role in [businessId], or null if they have no active membership
  /// there (i.e. the request must be rejected by the tenant guard).
  static MembershipRole? activeRole(
      List<Membership> memberships, String businessId) {
    for (final m in memberships) {
      if (m.isActive && m.businessId == businessId) return m.role;
    }
    return null;
  }

  static bool hasAccess(List<Membership> memberships, String businessId) =>
      activeRole(memberships, businessId) != null;
}
