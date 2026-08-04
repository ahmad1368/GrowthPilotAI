import '../../../../objectbox.g.dart';
import '../entities/audit_log_entity.dart';

/// Append-only access to the audit trail (Issue #343, acceptance
/// criterion 3) — intentionally exposes no update/delete method so a
/// recorded entry can never be altered after the fact.
class AuditLogRepository {
  final Box<AuditLogEntity> _box;

  AuditLogRepository(this._box);

  int record(AuditLogEntity entry) => _box.put(entry);

  List<AuditLogEntity> getAll() => _box.getAll();
}
