import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';

/// A single-use, time-boxed invitation for [invitedEmail] to join
/// [businessId] with [role] (Issue #156: org invitation flow).
@immutable
class OrgInvite {
  final String token;
  final String businessId;
  final String invitedEmail;
  final MembershipRole role;
  final DateTime createdAt;
  final DateTime expiresAt;
  final bool redeemed;

  const OrgInvite({
    required this.token,
    required this.businessId,
    required this.invitedEmail,
    required this.role,
    required this.createdAt,
    required this.expiresAt,
    this.redeemed = false,
  });

  OrgInvite markRedeemed() => OrgInvite(
        token: token,
        businessId: businessId,
        invitedEmail: invitedEmail,
        role: role,
        createdAt: createdAt,
        expiresAt: expiresAt,
        redeemed: true,
      );
}
