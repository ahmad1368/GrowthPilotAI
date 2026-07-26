import 'package:objectbox/objectbox.dart';
import 'inventory_category_entity.dart';

/// A tracked stock item (Issue #435) — the foundational SKU/inventory data
/// model this app previously lacked. Barcode/SKU generation (#437),
/// POS-triggered real-time deduction (#439), and low-stock notifications
/// (#440) are separate follow-up issues; this is manual quantity tracking.
@Entity()
class InventoryItemEntity {
  @Id()
  int id = 0;

  String name;

  int quantityOnHand;

  int reorderThreshold;

  double unitCost;

  /// Optional hierarchical category (Issue #436).
  final category = ToOne<InventoryCategoryEntity>();

  InventoryItemEntity({
    this.id = 0,
    required this.name,
    required this.quantityOnHand,
    required this.reorderThreshold,
    required this.unitCost,
  });
}
