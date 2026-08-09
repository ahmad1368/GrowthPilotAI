import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/models/membership.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:growth_pilot_ai/core/models/org_invite.dart';
import 'package:growth_pilot_ai/validators/org_invite_validator.dart';

/// Converts a valid, unexpired [OrgInvite] into an active [Membership] for
/// [userId] (Issue #156: token-based invitation flow).
class RedeemOrgInvite {
  static OmniResult<Membership> call(
      OrgInvite invite, String userId, DateTime now) async {
    final rejection = OrgInviteValidator.rejectionReason(invite, now);
    if (rejection != null) {
      return OmniResponse.error(rejection, statusCode: 403);
    }

    final membership = Membership(
      userId: userId,
      businessId: invite.businessId,
      role: invite.role,
      status: MembershipStatus.active,
    );

    return OmniResponse.success(membership,
        message: 'Joined organization as ${invite.role.name}.');
  }
}
