import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/enum/membership_role.dart';

/// One line of the organization audit trail (Issue #156 Acceptance
/// Criteria: "Audit Trail"). [formatted] matches the required log shape:
/// `[Timestamp] - [User Name] - [Action] - [Role Used]`.
@immutable
class OrgAuditEntry {
  final DateTime timestamp;
  final String userName;
  final String action;
  final MembershipRole roleUsed;

  const OrgAuditEntry({
    required this.timestamp,
    required this.userName,
    required this.action,
    required this.roleUsed,
  });

  String get formatted =>
      '[${timestamp.toIso8601String()}] - [$userName] - [$action] - [${roleUsed.name}]';
}
