import 'package:growth_pilot_ai/business/compute_item_co_occurrence_counts.dart';
import 'package:growth_pilot_ai/business/group_stock_movements_into_baskets.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/product_bundle_recommendation.dart';

/// Top frequently co-purchased item pairs with a suggested bundle price
/// (Issue #378): a simplified market-basket analysis over sale movements,
/// not the issue's literal association-rule-mining engine.
class ComputeProductBundleRecommendations {
  static const minCoOccurrence = 2;
  static const bundleDiscountRate = 0.1;
  static const maxRecommendations = 5;

  static List<ProductBundleRecommendation> call(
    List<StockMovementEntity> movements,
    List<InventoryItemEntity> items,
  ) {
    final baskets = GroupStockMovementsIntoBaskets.call(movements);
    final counts = ComputeItemCoOccurrenceCounts.call(baskets);
    final totalBaskets = baskets.length;
    final costByName = {
      for (final item in items) item.name.toLowerCase(): item.unitCost,
    };

    final recommendations = <ProductBundleRecommendation>[];
    counts.forEach((key, count) {
      if (count < minCoOccurrence) return;
      final parts = key.split('::');
      final combinedBasePrice = (costByName[parts[0].toLowerCase()] ?? 0) +
          (costByName[parts[1].toLowerCase()] ?? 0);
      final suggestedBundlePrice = combinedBasePrice * (1 - bundleDiscountRate);

      recommendations.add(ProductBundleRecommendation(
        itemA: parts[0],
        itemB: parts[1],
        coOccurrenceCount: count,
        supportRatio: totalBaskets <= 0 ? 0 : count / totalBaskets,
        combinedBasePrice: combinedBasePrice,
        suggestedBundlePrice: suggestedBundlePrice,
        discountAmount: combinedBasePrice - suggestedBundlePrice,
      ));
    });

    recommendations.sort((a, b) => b.coOccurrenceCount.compareTo(a.coOccurrenceCount));
    return recommendations.take(maxRecommendations).toList();
  }
}
