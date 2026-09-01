import '../../../../objectbox.g.dart';
import '../entities/dispute_evidence_entity.dart';

/// Append-only access to submitted dispute evidence (Issue #427,
/// acceptance criterion 5) — mirrors [AuditLogRepository]'s
/// record-only pattern; no update/delete method is exposed so the
/// dossier can never be altered after submission.
class DisputeEvidenceRepository {
  final Box<DisputeEvidenceEntity> _box;

  DisputeEvidenceRepository(this._box);

  int record(DisputeEvidenceEntity evidence) => _box.put(evidence);

  List<DisputeEvidenceEntity> getAll() => _box.getAll();

  List<DisputeEvidenceEntity> forAccount(int escrowAccountId) =>
      getAll().where((e) => e.escrowAccountId == escrowAccountId).toList();
}
