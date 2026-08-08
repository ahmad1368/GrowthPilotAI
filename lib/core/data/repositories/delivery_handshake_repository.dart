import '../../../../objectbox.g.dart';
import '../entities/delivery_handshake_entity.dart';

/// Thin ObjectBox wrapper for QR handshake tokens (Issue #155).
class DeliveryHandshakeRepository {
  final Box<DeliveryHandshakeEntity> _box;

  DeliveryHandshakeRepository(this._box);

  DeliveryHandshakeEntity? getForDelivery(int deliveryId) {
    final query =
        _box.query(DeliveryHandshakeEntity_.deliveryId.equals(deliveryId)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  int upsert(DeliveryHandshakeEntity handshake) => _box.put(handshake);
}
