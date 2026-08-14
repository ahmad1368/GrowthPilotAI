import 'package:objectbox/objectbox.dart';

/// A recorded batch of stock received at a specific unit cost (Issue #446):
/// the cost-basis data FIFO/LIFO/weighted-average valuation is computed
/// from. This app has no per-item costs on goods receipts (#444) or
/// purchase orders (#443) yet, so layers are logged manually here, same gap
/// as #439's stock movements.
@Entity()
class InventoryCostLayerEntity {
  @Id()
  int id = 0;

  @Index()
  int itemId;

  String itemName;

  int quantity;

  double unitCost;

  DateTime receivedAt;

  InventoryCostLayerEntity({
    this.id = 0,
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.unitCost,
    required this.receivedAt,
  });
}
