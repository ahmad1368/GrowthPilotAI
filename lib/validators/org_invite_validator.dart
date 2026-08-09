import 'package:growth_pilot_ai/core/models/org_invite.dart';

/// Checks whether an [OrgInvite] can still be redeemed: unused and not past
/// its 48-hour expiry (Issue #156 Acceptance Criteria: "Invite Security").
class OrgInviteValidator {
  static bool isRedeemable(OrgInvite invite, DateTime now) {
    if (invite.redeemed) return false;
    return now.isBefore(invite.expiresAt);
  }

  static String? rejectionReason(OrgInvite invite, DateTime now) {
    if (invite.redeemed) return 'Invitation already used.';
    if (!now.isBefore(invite.expiresAt)) return 'Invitation has expired.';
    return null;
  }
}
