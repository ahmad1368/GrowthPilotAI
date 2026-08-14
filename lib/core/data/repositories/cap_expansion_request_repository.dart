import '../../../../objectbox.g.dart';
import '../entities/cap_expansion_request_entity.dart';

/// Insert-or-update CRUD for cap expansion requests (Issue #344),
/// mirroring [MerchantConfigRepository]'s upsert pattern — `save` lets
/// admin review update a request's status in place.
class CapExpansionRequestRepository {
  final Box<CapExpansionRequestEntity> _box;

  CapExpansionRequestRepository(this._box);

  int save(CapExpansionRequestEntity request) => _box.put(request);

  List<CapExpansionRequestEntity> getAll() => _box.getAll();
}
