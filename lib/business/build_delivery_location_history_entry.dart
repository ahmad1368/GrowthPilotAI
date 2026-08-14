import 'package:growth_pilot_ai/core/data/entities/delivery_location_history_entity.dart';

/// Constructs one route-history point (Issue #155), kept out of the
/// handler so the append logic is independently testable.
class BuildDeliveryLocationHistoryEntry {
  static DeliveryLocationHistoryEntity call(int deliveryId, double lat, double lng, DateTime now) {
    return DeliveryLocationHistoryEntity(deliveryId: deliveryId, lat: lat, lng: lng, recordedAt: now);
  }
}
