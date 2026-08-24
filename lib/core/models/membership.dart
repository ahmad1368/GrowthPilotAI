import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';
import 'package:growth_pilot_ai/core/enum/permission.dart';

/// Junction linking an identity ([userId]) to a tenant ([businessId]) with a
/// [role] and [status] — the bridge that enables multi-business access.
/// [customPermissions] are additive grants beyond [role]'s defaults (Issue
/// #174) — e.g. a buyer specifically granted [Permission.viewReports]
/// without promoting them to admin.
@immutable
class Membership {
  final String userId;
  final String businessId;
  final MembershipRole role;
  final MembershipStatus status;
  final Set<Permission> customPermissions;

  const Membership({
    required this.userId,
    required this.businessId,
    this.role = MembershipRole.buyer,
    this.status = MembershipStatus.pending,
    this.customPermissions = const {},
  });

  bool get isActive => status == MembershipStatus.active;
}
