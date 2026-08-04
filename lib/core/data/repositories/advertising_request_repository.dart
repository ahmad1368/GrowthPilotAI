import '../../../../objectbox.g.dart';
import '../entities/advertising_request_entity.dart';

/// Insert-or-update CRUD for advertising requests (Issue #401),
/// mirroring [CapExpansionRequestRepository]'s upsert pattern.
class AdvertisingRequestRepository {
  final Box<AdvertisingRequestEntity> _box;

  AdvertisingRequestRepository(this._box);

  int save(AdvertisingRequestEntity request) => _box.put(request);

  List<AdvertisingRequestEntity> getAll() => _box.getAll();
}
