import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_valuation_point.dart';

/// Cumulative cost-layer investment over time (Issue #446), oldest first —
/// how much capital has gone into inventory as each layer was recorded.
/// Pure.
class BuildValuationTrend {
  static List<InventoryValuationPoint> call(List<InventoryCostLayerEntity> layers) {
    final sorted = [...layers]..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
    var running = 0.0;
    return [
      for (final layer in sorted)
        InventoryValuationPoint(
          receivedAt: layer.receivedAt,
          cumulativeValue: running += layer.quantity * layer.unitCost,
        ),
    ];
  }
}
