import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_basket_optimization.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  group('ComputeBasketOptimization', () {
    test('flags excess stock for slow-moving items with no sales', () {
      final now = DateTime(2024, 2, 10);
      final item = InventoryItemEntity(
        id: 1,
        name: 'Overstocked Widget',
        quantityOnHand: 50,
        reorderThreshold: 5,
        unitCost: 4,
      );

      final result = ComputeBasketOptimization.call(
        [item],
        const [],
        const <InventoryCostLayerEntity>[],
        now,
        const Duration(days: 90),
      );

      expect(result.single.idealQuantity, 5);
      expect(result.single.excessQuantity, 45);
      expect(result.single.shortfallQuantity, 0);
      expect(result.single.holdingCostExposure, 180);
      expect(result.single.recommendedAction, 'Reduce by 45 units');
    });

    test('recommends a reorder quantity for high-velocity items running low',
        () {
      final now = DateTime(2024, 2, 10);
      final item = InventoryItemEntity(
        id: 1,
        name: 'Fast Widget',
        quantityOnHand: 5,
        reorderThreshold: 2,
        unitCost: 3,
      );
      final movements = <StockMovementEntity>[
        StockMovementEntity(
          itemName: item.name,
          quantity: 90,
          resultingQuantityOnHand: 5,
          occurredAt: DateTime(2024, 1, 15),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputeBasketOptimization.call(
        [item],
        movements,
        const <InventoryCostLayerEntity>[],
        now,
        const Duration(days: 90),
      );

      expect(result.single.idealQuantity, 30);
      expect(result.single.shortfallQuantity, 25);
      expect(result.single.excessQuantity, 0);
      expect(result.single.holdingCostExposure, 0);
      expect(result.single.recommendedAction, 'Reorder 25 units');
    });

    test('marks a balanced basket as optimal', () {
      final now = DateTime(2024, 2, 10);
      final item = InventoryItemEntity(
        id: 1,
        name: 'Balanced Widget',
        quantityOnHand: 10,
        reorderThreshold: 1,
        unitCost: 5,
      );
      final movements = <StockMovementEntity>[
        StockMovementEntity(
          itemName: item.name,
          quantity: 30,
          resultingQuantityOnHand: 10,
          occurredAt: DateTime(2024, 1, 15),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputeBasketOptimization.call(
        [item],
        movements,
        const <InventoryCostLayerEntity>[],
        now,
        const Duration(days: 90),
      );

      expect(result.single.idealQuantity, 10);
      expect(result.single.excessQuantity, 0);
      expect(result.single.shortfallQuantity, 0);
      expect(result.single.recommendedAction, 'Optimal');
    });

    test('sorts items by holding-cost exposure descending', () {
      final now = DateTime(2024, 2, 10);
      final lowExposure = InventoryItemEntity(
        id: 1,
        name: 'Low Exposure Widget',
        quantityOnHand: 10,
        reorderThreshold: 5,
        unitCost: 1,
      );
      final highExposure = InventoryItemEntity(
        id: 2,
        name: 'High Exposure Widget',
        quantityOnHand: 100,
        reorderThreshold: 5,
        unitCost: 10,
      );

      final result = ComputeBasketOptimization.call(
        [lowExposure, highExposure],
        const [],
        const <InventoryCostLayerEntity>[],
        now,
        const Duration(days: 90),
      );

      expect(result.first.item.name, 'High Exposure Widget');
      expect(result.last.item.name, 'Low Exposure Widget');
    });
  });
}
