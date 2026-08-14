import 'package:objectbox/objectbox.dart';

/// One recorded point on a delivery's route (Issue #155) — the "Route
/// History" AC. Purged after 30 days via
/// [PurgeStaleDeliveryLocationHistory], keeping only the final
/// [DeliveryEntity.status] for accounting (#149).
@Entity()
class DeliveryLocationHistoryEntity {
  @Id()
  int id = 0;

  @Index()
  int deliveryId;

  double lat;
  double lng;

  @Property(type: PropertyType.date)
  DateTime recordedAt;

  DeliveryLocationHistoryEntity({
    this.id = 0,
    required this.deliveryId,
    required this.lat,
    required this.lng,
    required this.recordedAt,
  });
}
