import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// Predicted days until an item runs out based on recent sales velocity
/// (Issue #360). [daysUntilStockout] is null when the item has no sales
/// in the selected period, so no depletion trend can be projected.
class StockDepletionForecast {
  final InventoryItemEntity item;
  final double dailyVelocity;
  final double? daysUntilStockout;
  final bool isCritical;

  const StockDepletionForecast({
    required this.item,
    required this.dailyVelocity,
    required this.daysUntilStockout,
    required this.isCritical,
  });
}
