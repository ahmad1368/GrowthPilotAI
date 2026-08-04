import '../../../../objectbox.g.dart';
import '../entities/geofence_zone_entity.dart';

/// Insert-or-update CRUD for geofence zones (Issue #346), mirroring
/// [MerchantConfigRepository]'s upsert pattern.
class GeofenceZoneRepository {
  final Box<GeofenceZoneEntity> _box;

  GeofenceZoneRepository(this._box);

  int save(GeofenceZoneEntity zone) => _box.put(zone);

  List<GeofenceZoneEntity> getAll() => _box.getAll();
}
