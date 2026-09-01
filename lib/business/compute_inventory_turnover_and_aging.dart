import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_turnover_and_aging_snapshot.dart';

/// Turnover ratio + aging-stock view over a customizable [period] (Issue
/// #447), using the locally available stock-movement and cost-layer ledgers.
class ComputeInventoryTurnoverAndAging {
  static List<InventoryTurnoverAndAgingSnapshot> call(
    List<InventoryItemEntity> items,
    List<StockMovementEntity> movements,
    List<InventoryCostLayerEntity> layers,
    DateTime now,
    Duration period,
  ) {
    final periodStart = now.subtract(period);
    final sortedItems = [...items]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return sortedItems.map((item) {
      final salesUnits = movements
          .where((m) =>
              m.itemName.toLowerCase() == item.name.toLowerCase() &&
              m.type == StockMovementType.sale &&
              m.occurredAt.isAfter(periodStart))
          .fold<int>(0, (sum, m) => sum + m.quantity);

      final turnoverRatio =
          item.quantityOnHand <= 0 ? 0.0 : salesUnits / item.quantityOnHand;

      final relevantLayers = layers.where((l) => l.itemId == item.id).toList()
        ..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
      final agingDays = relevantLayers.isEmpty
          ? 0
          : now.difference(relevantLayers.first.receivedAt).inDays;

      final statusLabel = turnoverRatio >= 1.0 && agingDays <= 45
          ? 'Fast moving'
          : (turnoverRatio <= 0.5 || agingDays >= 45 ? 'Needs review' : 'Watch');

      return InventoryTurnoverAndAgingSnapshot(
        item: item,
        salesUnits: salesUnits,
        turnoverRatio: turnoverRatio,
        agingDays: agingDays,
        statusLabel: statusLabel,
      );
    }).toList()
      ..sort((a, b) => b.turnoverRatio.compareTo(a.turnoverRatio));
  }
}
