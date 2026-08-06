import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// One merchant's stock allocation reserved against a
/// [SeasonalCatalogItemEntity] via a fractional upfront deposit
/// (Issue #417, acceptance criteria 2 and 5).
@Entity()
class PreOrderReservationEntity {
  @Id()
  int id = 0;

  @Index()
  int catalogItemId;

  String merchantName;
  int quantity;
  double depositAmount;
  int dbStatus; // PreOrderReservationStatus index

  @Property(type: PropertyType.date)
  DateTime reservedAt;

  PreOrderReservationEntity({
    this.id = 0,
    required this.catalogItemId,
    required this.merchantName,
    required this.quantity,
    required this.depositAmount,
    this.dbStatus = 0, // PreOrderReservationStatus.depositPaid
    required this.reservedAt,
  });

  PreOrderReservationStatus get status => PreOrderReservationStatus.values[dbStatus];
  set status(PreOrderReservationStatus value) => dbStatus = value.index;
}
