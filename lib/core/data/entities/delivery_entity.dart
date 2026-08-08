import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

/// One in-progress "Last-Mile" delivery tied to a #147 [PaymentEntity]
/// (Issue #155) — live GPS lives here directly (no Redis) since it only
/// ever needs the latest value, not history ([DeliveryLocationHistoryEntity]).
@Entity()
class DeliveryEntity {
  @Id()
  int id = 0;

  @Index()
  int requestId;
  @Index()
  int paymentId;

  String courierId;
  int dbStatus; // DeliveryStatus index

  double? courierLat;
  double? courierLng;

  @Property(type: PropertyType.date)
  DateTime? lastLocationAt;

  bool trackingConsentGiven;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  @Property(type: PropertyType.date)
  DateTime? completedAt;

  DeliveryEntity({
    this.id = 0,
    required this.requestId,
    required this.paymentId,
    required this.courierId,
    this.dbStatus = 0, // DeliveryStatus.pending
    this.courierLat,
    this.courierLng,
    this.lastLocationAt,
    this.trackingConsentGiven = false,
    required this.createdAt,
    this.completedAt,
  });

  DeliveryStatus get status => DeliveryStatus.values[dbStatus];
  set status(DeliveryStatus value) => dbStatus = value.index;
}
