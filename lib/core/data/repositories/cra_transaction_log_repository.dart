import '../../../../objectbox.g.dart';
import '../entities/cra_transaction_log_entity.dart';

/// Append-only access to the CRA compliance ledger (Issue #428,
/// acceptance criteria 1 and 5) — mirrors [AuditLogRepository]'s
/// record-only pattern; no update/delete method is exposed so a
/// logged transaction can never be altered after the fact.
class CraTransactionLogRepository {
  final Box<CraTransactionLogEntity> _box;

  CraTransactionLogRepository(this._box);

  int record(CraTransactionLogEntity entry) => _box.put(entry);

  List<CraTransactionLogEntity> getAll() => _box.getAll();

  bool hasLogFor(int gatewayTransactionId) =>
      getAll().any((e) => e.gatewayTransactionId == gatewayTransactionId);
}
