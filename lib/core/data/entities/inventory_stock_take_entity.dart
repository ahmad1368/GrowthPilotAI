import 'package:objectbox/objectbox.dart';

/// One physical-count audit record (Issue #441): the system-recorded
/// quantity vs. what was actually counted, for reconciliation. Snapshots
/// the item name rather than relating to [InventoryItemEntity] so the
/// audit trail survives even if the item is later renamed or removed.
@Entity()
class InventoryStockTakeEntity {
  @Id()
  int id = 0;

  String itemName;

  int systemQuantity;

  int physicalQuantity;

  @Index()
  DateTime takenAt;

  InventoryStockTakeEntity({
    this.id = 0,
    required this.itemName,
    required this.systemQuantity,
    required this.physicalQuantity,
    required this.takenAt,
  });
}
