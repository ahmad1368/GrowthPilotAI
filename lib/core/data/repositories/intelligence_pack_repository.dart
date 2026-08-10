import '../../../../objectbox.g.dart';
import '../entities/intelligence_pack_entity.dart';

/// On-device store of downloaded Intelligence Packs (Issue #86) — one
/// row per sector, upserted in place.
class IntelligencePackRepository {
  final Box<IntelligencePackEntity> _box;

  IntelligencePackRepository(this._box);

  IntelligencePackEntity? getForSector(String sectorId) {
    final query = _box.query(IntelligencePackEntity_.sectorId.equals(sectorId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(IntelligencePackEntity pack) => _box.put(pack);
}
