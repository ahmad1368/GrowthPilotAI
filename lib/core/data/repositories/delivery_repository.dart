import '../../../../objectbox.g.dart';
import '../entities/delivery_entity.dart';

/// Thin ObjectBox wrapper for deliveries (Issue #155).
class DeliveryRepository {
  final Box<DeliveryEntity> _box;

  DeliveryRepository(this._box);

  DeliveryEntity? getById(int id) => _box.get(id);

  List<DeliveryEntity> getForRequest(int requestId) =>
      _box.getAll().where((d) => d.requestId == requestId).toList();

  int upsert(DeliveryEntity delivery) => _box.put(delivery);
}
