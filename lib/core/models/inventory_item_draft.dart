import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// Bundles a not-yet-persisted [InventoryItemEntity] with its custom
/// key/value attributes (Issue #438), since attributes need the item's
/// assigned id before they can be inserted.
class InventoryItemDraft {
  final InventoryItemEntity item;
  final List<MapEntry<String, String>> attributes;

  const InventoryItemDraft({required this.item, required this.attributes});
}
