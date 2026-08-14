import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_price_recommendations.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  final now = DateTime(2024, 2, 10);

  group('ComputePriceRecommendations', () {
    test('suggests a capped price increase for a fast-moving item', () {
      final item = InventoryItemEntity(
          id: 1, name: 'Fast', quantityOnHand: 10, reorderThreshold: 2, unitCost: 20);
      final movements = [
        StockMovementEntity(
          itemName: 'Fast',
          quantity: 20,
          resultingQuantityOnHand: 10,
          occurredAt: now.subtract(const Duration(days: 15)),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputePriceRecommendations.call(
          [item], movements, const [], now, const Duration(days: 90));

      expect(result.single.turnoverRatio, 2.0);
      expect(result.single.priceChangePercent, closeTo(30, 1e-9));
      expect(result.single.suggestedPrice, closeTo(26, 1e-9));
      expect(result.single.recommendedAction, 'Increase price');
    });

    test('suggests a capped price decrease for a zero-turnover item', () {
      final item = InventoryItemEntity(
          id: 1, name: 'Dead', quantityOnHand: 10, reorderThreshold: 2, unitCost: 20);

      final result = ComputePriceRecommendations.call(
          [item], const [], const [], now, const Duration(days: 90));

      expect(result.single.turnoverRatio, 0.0);
      expect(result.single.priceChangePercent, closeTo(-30, 1e-9));
      expect(result.single.suggestedPrice, closeTo(14, 1e-9));
      expect(result.single.recommendedAction, 'Decrease price');
    });

    test('holds the price for a steady turnover-ratio-1.0 item', () {
      final item = InventoryItemEntity(
          id: 1, name: 'Steady', quantityOnHand: 10, reorderThreshold: 2, unitCost: 20);
      final movements = [
        StockMovementEntity(
          itemName: 'Steady',
          quantity: 10,
          resultingQuantityOnHand: 10,
          occurredAt: now.subtract(const Duration(days: 15)),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputePriceRecommendations.call(
          [item], movements, const <InventoryCostLayerEntity>[], now, const Duration(days: 90));

      expect(result.single.priceChangePercent, 0);
      expect(result.single.suggestedPrice, 20);
      expect(result.single.recommendedAction, 'Hold price');
    });

    test('sorts by the largest absolute price change first', () {
      final fast = InventoryItemEntity(
          id: 1, name: 'Fast', quantityOnHand: 10, reorderThreshold: 2, unitCost: 20);
      final steady = InventoryItemEntity(
          id: 2, name: 'Steady', quantityOnHand: 10, reorderThreshold: 2, unitCost: 20);
      final movements = [
        StockMovementEntity(
          itemName: 'Fast',
          quantity: 20,
          resultingQuantityOnHand: 10,
          occurredAt: now.subtract(const Duration(days: 15)),
          dbType: StockMovementType.sale.index,
        ),
        StockMovementEntity(
          itemName: 'Steady',
          quantity: 10,
          resultingQuantityOnHand: 10,
          occurredAt: now.subtract(const Duration(days: 15)),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputePriceRecommendations.call(
          [steady, fast], movements, const [], now, const Duration(days: 90));

      expect(result.first.item.name, 'Fast');
      expect(result.last.item.name, 'Steady');
    });
  });
}
