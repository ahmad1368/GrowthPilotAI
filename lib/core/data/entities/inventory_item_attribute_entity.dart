import 'package:objectbox/objectbox.dart';
import 'inventory_item_entity.dart';

/// A single custom key/value attribute on an inventory item (Issue #438),
/// e.g. "Size" -> "M" or "Color" -> "Red" — a dynamic alternative to
/// hardcoding a fixed attribute schema per business type.
@Entity()
class InventoryItemAttributeEntity {
  @Id()
  int id = 0;

  String key;

  String value;

  final item = ToOne<InventoryItemEntity>();

  InventoryItemAttributeEntity({this.id = 0, required this.key, required this.value});
}
