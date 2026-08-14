import '../../../../objectbox.g.dart';
import '../entities/rewarded_unlock_entity.dart';

/// Append-only access to the rewarded unlock log (Issue #405,
/// acceptance criteria 4-5) — intentionally exposes no update/delete so
/// a granted unlock can never be silently altered, mirroring
/// [AuditLogRepository]'s immutable-log pattern.
class RewardedUnlockRepository {
  final Box<RewardedUnlockEntity> _box;

  RewardedUnlockRepository(this._box);

  int record(RewardedUnlockEntity unlock) => _box.put(unlock);

  List<RewardedUnlockEntity> getAll() => _box.getAll();
}
