import 'package:growth_pilot_ai/business/membership_resolver.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';

/// Action-level permission checks layered on top of [MembershipResolver]'s
/// tenant isolation (Issue #156: "Only Managers can approve invoices over
/// $5,000" style rules — mapped onto this app's existing owner/admin/buyer/
/// vendor roles rather than introducing a new MANAGER role).
class OrgActionGuard {
  static const double buyerApprovalCapCad = 1000;

  /// Whether the active role for [userId] in [businessId] may approve a
  /// payment of [amountCad]. Owners/admins are unlimited, buyers are capped
  /// at [buyerApprovalCapCad], vendors can never approve payments.
  static bool canApprovePayment(
    List<Membership> memberships,
    String businessId,
    double amountCad,
  ) {
    final role = MembershipResolver.activeRole(memberships, businessId);
    if (role == null) return false;

    switch (role) {
      case MembershipRole.owner:
      case MembershipRole.admin:
        return true;
      case MembershipRole.buyer:
        return amountCad <= buyerApprovalCapCad;
      case MembershipRole.vendor:
        return false;
    }
  }
}
