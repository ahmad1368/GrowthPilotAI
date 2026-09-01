import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';

/// Projects a stock-out ETA per item from recent sales velocity
/// (Issue #360), additive to the already-shipped static reorder-threshold
/// alerts (#440): items with no depletion trend sort last.
class ComputeStockDepletionForecast {
  static const criticalDaysThreshold = 14;

  static List<StockDepletionForecast> call(
    List<InventoryItemEntity> items,
    List<StockMovementEntity> movements,
    DateTime now,
    Duration period,
  ) {
    final periodStart = now.subtract(period);

    final forecasts = items.map((item) {
      final salesUnits = movements
          .where((m) =>
              m.itemName.toLowerCase() == item.name.toLowerCase() &&
              m.type == StockMovementType.sale &&
              m.occurredAt.isAfter(periodStart))
          .fold<int>(0, (sum, m) => sum + m.quantity);

      final dailyVelocity = salesUnits / period.inDays;
      final daysUntilStockout =
          dailyVelocity <= 0 ? null : item.quantityOnHand / dailyVelocity;

      return StockDepletionForecast(
        item: item,
        dailyVelocity: dailyVelocity,
        daysUntilStockout: daysUntilStockout,
        isCritical: daysUntilStockout != null &&
            daysUntilStockout <= criticalDaysThreshold,
      );
    }).toList();

    forecasts.sort((a, b) {
      if (a.daysUntilStockout == null && b.daysUntilStockout == null) return 0;
      if (a.daysUntilStockout == null) return 1;
      if (b.daysUntilStockout == null) return -1;
      return a.daysUntilStockout!.compareTo(b.daysUntilStockout!);
    });
    return forecasts;
  }
}
