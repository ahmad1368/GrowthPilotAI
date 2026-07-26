import 'package:objectbox/objectbox.dart';
import 'inventory_category_entity.dart';
import 'inventory_item_attribute_entity.dart';
import 'vendor_entity.dart';

/// A tracked stock item (Issue #435) — the foundational SKU/inventory data
/// model this app previously lacked. SKU generation is #437; camera-based
/// barcode scanning needs a new native package and physical-device QA this
/// environment can't verify, so it's left for a dedicated follow-up.
/// POS-triggered real-time deduction (#439) and low-stock notifications
/// (#440) are separate follow-up issues; this is manual quantity tracking.
@Entity()
class InventoryItemEntity {
  @Id()
  int id = 0;

  String name;

  int quantityOnHand;

  int reorderThreshold;

  double unitCost;

  /// Optional unique item identifier (Issue #437) — user-entered or
  /// auto-generated, empty if unset.
  String sku;

  /// Optional expiry date for perishables (Issue #438).
  @Property(type: PropertyType.date)
  DateTime? expiryDate;

  /// Optional serial number, e.g. for high-value repair parts (Issue #438).
  String serialNumber;

  /// Optional hierarchical category (Issue #436).
  final category = ToOne<InventoryCategoryEntity>();

  /// Optional supplier this item is sourced from (Issue #442).
  final vendor = ToOne<VendorEntity>();

  /// Dynamic custom attributes, e.g. size/color (Issue #438).
  @Backlink('item')
  final attributes = ToMany<InventoryItemAttributeEntity>();

  InventoryItemEntity({
    this.id = 0,
    required this.name,
    required this.quantityOnHand,
    required this.reorderThreshold,
    required this.unitCost,
    this.sku = '',
    this.expiryDate,
    this.serialNumber = '',
  });
}
