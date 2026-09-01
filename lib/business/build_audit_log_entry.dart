import 'package:growth_pilot_ai/core/data/entities/audit_log_entity.dart';

/// Builds one immutable audit trail entry for an admin-driven change
/// (Issue #343, acceptance criterion 1) — this app has no auth/session
/// system, so [adminId] defaults to the same single-admin identity
/// [OmniLogger.error] uses (Issue #165: neither should hardcode a real
/// person's name as the default identity for every entry).
class BuildAuditLogEntry {
  static AuditLogEntity call({
    String adminId = 'local-user',
    required String changeType,
    required String targetMerchant,
    String previousValue = '',
    required String newValue,
    DateTime? timestamp,
  }) {
    return AuditLogEntity(
      adminId: adminId,
      changeType: changeType,
      targetMerchant: targetMerchant,
      previousValue: previousValue,
      newValue: newValue,
      timestamp: timestamp ?? DateTime.now(),
    );
  }
}
