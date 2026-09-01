import 'package:objectbox/objectbox.dart';

/// An active hold on inventory quantity for an in-progress online checkout
/// session (Issue #445). Reduces the item's available-to-sell quantity
/// without touching [quantityOnHand] until [ConfirmStockReservation] turns
/// it into a real [StockMovementEntity], or [ReleaseStockReservation]
/// cancels it (checkout abandoned/expired).
@Entity()
class StockReservationEntity {
  @Id()
  int id = 0;

  @Index()
  int itemId;

  String itemName;

  int quantityReserved;

  DateTime createdAt;

  StockReservationEntity({
    this.id = 0,
    required this.itemId,
    required this.itemName,
    required this.quantityReserved,
    required this.createdAt,
  });
}
