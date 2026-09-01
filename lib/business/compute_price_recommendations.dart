import 'package:growth_pilot_ai/business/compute_inventory_turnover_and_aging.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/price_recommendation.dart';

/// Suggests a price adjustment per item from sales velocity (Issue #356),
/// reusing [ComputeInventoryTurnoverAndAging] (#447) — not the issue's
/// literal competitor-pricing-informed model, since this app has no
/// competitor price feed. [maxAdjustment] is the margin-protection
/// guardrail: it caps how far a suggestion can move off the base price
/// in either direction.
class ComputePriceRecommendations {
  static const sensitivity = 0.3;
  static const maxAdjustment = 0.3;

  static List<PriceRecommendation> call(
    List<InventoryItemEntity> items,
    List<StockMovementEntity> movements,
    List<InventoryCostLayerEntity> layers,
    DateTime now,
    Duration period,
  ) {
    final snapshots = ComputeInventoryTurnoverAndAging.call(
        items, movements, layers, now, period);

    return snapshots.map((s) {
      final adjustment =
          ((s.turnoverRatio - 1.0) * sensitivity).clamp(-maxAdjustment, maxAdjustment);
      final action = adjustment > 0.01
          ? 'Increase price'
          : (adjustment < -0.01 ? 'Decrease price' : 'Hold price');

      return PriceRecommendation(
        item: s.item,
        turnoverRatio: s.turnoverRatio,
        agingDays: s.agingDays,
        currentBasePrice: s.item.unitCost,
        suggestedPrice: s.item.unitCost * (1 + adjustment),
        priceChangePercent: adjustment * 100,
        recommendedAction: action,
      );
    }).toList()
      ..sort((a, b) =>
          b.priceChangePercent.abs().compareTo(a.priceChangePercent.abs()));
  }
}
