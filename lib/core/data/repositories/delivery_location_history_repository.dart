import '../../../../objectbox.g.dart';
import '../entities/delivery_location_history_entity.dart';

/// Thin ObjectBox wrapper for a delivery's route history (Issue #155).
class DeliveryLocationHistoryRepository {
  final Box<DeliveryLocationHistoryEntity> _box;

  DeliveryLocationHistoryRepository(this._box);

  List<DeliveryLocationHistoryEntity> getForDelivery(int deliveryId) => _box
      .query(DeliveryLocationHistoryEntity_.deliveryId.equals(deliveryId))
      .build()
      .find();

  int insert(DeliveryLocationHistoryEntity entry) => _box.put(entry);

  void removeAll(List<DeliveryLocationHistoryEntity> entries) =>
      _box.removeMany(entries.map((e) => e.id).toList());
}
