import 'package:growth_pilot_ai/core/enum/membership_role.dart';
import 'package:growth_pilot_ai/core/models/org_audit_entry.dart';
import 'package:growth_pilot_ai/core/utils/logger.dart';

/// Builds an [OrgAuditEntry] for an org-scoped action and writes it to the
/// central logger (Issue #156 Acceptance Criteria: "Audit Trail").
class RecordOrgAction {
  static OrgAuditEntry call(
    String userName,
    String action,
    MembershipRole roleUsed,
    DateTime now,
  ) {
    final entry = OrgAuditEntry(
      timestamp: now,
      userName: userName,
      action: action,
      roleUsed: roleUsed,
    );
    OmniLogger.info(entry.formatted);
    return entry;
  }
}
