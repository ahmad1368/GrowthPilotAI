import '../../../../objectbox.g.dart';
import '../entities/security_audit_log_entity.dart';

/// Append-only access to the security-audit trail (Issue #186, AC:
/// "Append-Only — the API must not have an endpoint to Update or Delete
/// these logs") — deliberately exposes no update or remove method.
class SecurityAuditLogRepository {
  final Box<SecurityAuditLogEntity> _box;

  SecurityAuditLogRepository(this._box);

  int add(SecurityAuditLogEntity entry) => _box.put(entry);

  List<SecurityAuditLogEntity> getAll() => _box.getAll();
}
