import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/enum/membership_status.dart';

/// Junction linking an identity ([userId]) to a tenant ([businessId]) with a
/// [role] and [status] — the bridge that enables multi-business access.
@immutable
class Membership {
  final String userId;
  final String businessId;
  final MembershipRole role;
  final MembershipStatus status;

  const Membership({
    required this.userId,
    required this.businessId,
    this.role = MembershipRole.buyer,
    this.status = MembershipStatus.pending,
  });

  bool get isActive => status == MembershipStatus.active;
}
