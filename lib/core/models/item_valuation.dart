import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// One item's computed inventory value (Issue #446) under whichever
/// [ValuationMethod] was selected.
class ItemValuation {
  final InventoryItemEntity item;
  final double totalValue;

  const ItemValuation({required this.item, required this.totalValue});
}
