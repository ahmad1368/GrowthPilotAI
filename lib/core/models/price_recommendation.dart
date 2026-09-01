import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// A per-item price adjustment suggestion (Issue #356). [currentBasePrice]
/// uses [InventoryItemEntity.unitCost] as the pricing baseline — the same
/// stand-in already used by Dead Stock Liquidation's (#370) clearance
/// pricing, since this app has no separate retail-price field.
class PriceRecommendation {
  final InventoryItemEntity item;
  final double turnoverRatio;
  final int agingDays;
  final double currentBasePrice;
  final double suggestedPrice;
  final double priceChangePercent;
  final String recommendedAction;

  const PriceRecommendation({
    required this.item,
    required this.turnoverRatio,
    required this.agingDays,
    required this.currentBasePrice,
    required this.suggestedPrice,
    required this.priceChangePercent,
    required this.recommendedAction,
  });
}
