import '../../../../objectbox.g.dart';
import '../entities/epsilon_consumption_entity.dart';

/// Per-user Privacy Budget ledger (Issue #81) — one row per user, upserted
/// in place, mirroring [KycVerificationRepository]'s shape.
class EpsilonConsumptionRepository {
  final Box<EpsilonConsumptionEntity> _box;

  EpsilonConsumptionRepository(this._box);

  EpsilonConsumptionEntity? getForUser(String userId) {
    final query = _box.query(EpsilonConsumptionEntity_.userId.equals(userId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(EpsilonConsumptionEntity entry) => _box.put(entry);
}
