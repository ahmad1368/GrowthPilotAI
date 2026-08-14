import 'dart:math';

import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/models/org_invite.dart';

/// Mints a secure, single-use invite token that expires 48 hours after
/// issuance (Issue #156 Acceptance Criteria: "Invite Security").
class GenerateOrgInvite {
  static const _tokenAlphabet =
      'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz23456789';

  static OrgInvite call(
    String businessId,
    String invitedEmail,
    MembershipRole role,
    DateTime now, {
    Random? random,
  }) {
    final rng = random ?? Random.secure();
    final token = List.generate(
        32, (_) => _tokenAlphabet[rng.nextInt(_tokenAlphabet.length)]).join();

    return OrgInvite(
      token: token,
      businessId: businessId,
      invitedEmail: invitedEmail,
      role: role,
      createdAt: now,
      expiresAt: now.add(const Duration(hours: 48)),
    );
  }
}
