import '../../../../objectbox.g.dart';
import '../entities/emergency_broadcast_entity.dart';

/// Insert-or-update CRUD for emergency broadcasts (Issue #345). `save`
/// lets an admin update a broadcast's reported read count over time as
/// delivery reports come in (acceptance criterion 3), mirroring
/// [MerchantConfigRepository]'s upsert pattern.
class EmergencyBroadcastRepository {
  final Box<EmergencyBroadcastEntity> _box;

  EmergencyBroadcastRepository(this._box);

  int save(EmergencyBroadcastEntity broadcast) => _box.put(broadcast);

  List<EmergencyBroadcastEntity> getAll() => _box.getAll();
}
