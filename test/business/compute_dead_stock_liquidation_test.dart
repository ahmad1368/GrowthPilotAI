import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_dead_stock_liquidation.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  group('ComputeDeadStockLiquidation', () {
    test('flags zero-turnover items and excludes items with sales', () {
      final now = DateTime(2024, 2, 10);
      final deadItem = InventoryItemEntity(
        id: 1,
        name: 'Stale Widget',
        quantityOnHand: 5,
        reorderThreshold: 2,
        unitCost: 10,
      );
      final sellingItem = InventoryItemEntity(
        id: 2,
        name: 'Popular Widget',
        quantityOnHand: 5,
        reorderThreshold: 2,
        unitCost: 10,
      );
      final movements = <StockMovementEntity>[
        StockMovementEntity(
          itemName: sellingItem.name,
          quantity: 2,
          resultingQuantityOnHand: 3,
          occurredAt: DateTime(2024, 1, 20),
          dbType: StockMovementType.sale.index,
        ),
      ];
      final layers = <InventoryCostLayerEntity>[
        InventoryCostLayerEntity(
          itemId: deadItem.id,
          itemName: deadItem.name,
          quantity: 5,
          unitCost: 10,
          receivedAt: DateTime(2024, 1, 1),
        ),
      ];

      final result = ComputeDeadStockLiquidation.call(
        [deadItem, sellingItem],
        movements,
        layers,
        now,
        const Duration(days: 90),
      );

      expect(result.length, 1);
      expect(result.single.item.name, 'Stale Widget');
      expect(result.single.tiedUpCapital, 50);
      expect(result.single.suggestedClearancePrice, 5);
      expect(result.single.recoverableCapital, 25);
      expect(result.single.suggestedChannel, 'Clearance pricing');
    });

    test('suggests bundling for large quantities and donation for very aged stock', () {
      final now = DateTime(2024, 6, 1);
      final bulkItem = InventoryItemEntity(
        id: 1,
        name: 'Bulk Widget',
        quantityOnHand: 20,
        reorderThreshold: 5,
        unitCost: 2,
      );
      final agedItem = InventoryItemEntity(
        id: 2,
        name: 'Ancient Widget',
        quantityOnHand: 3,
        reorderThreshold: 1,
        unitCost: 8,
      );
      final layers = <InventoryCostLayerEntity>[
        InventoryCostLayerEntity(
          itemId: bulkItem.id,
          itemName: bulkItem.name,
          quantity: 20,
          unitCost: 2,
          receivedAt: DateTime(2024, 5, 1),
        ),
        InventoryCostLayerEntity(
          itemId: agedItem.id,
          itemName: agedItem.name,
          quantity: 3,
          unitCost: 8,
          receivedAt: DateTime(2023, 10, 1),
        ),
      ];

      final result = ComputeDeadStockLiquidation.call(
        [bulkItem, agedItem],
        const [],
        layers,
        now,
        const Duration(days: 90),
      );

      final bulk = result.firstWhere((s) => s.item.name == 'Bulk Widget');
      final aged = result.firstWhere((s) => s.item.name == 'Ancient Widget');
      expect(bulk.suggestedChannel, 'Bundling');
      expect(aged.suggestedChannel, 'Donation channel');
    });

    test('excludes items with zero quantity on hand', () {
      final now = DateTime(2024, 2, 10);
      final emptyItem = InventoryItemEntity(
        id: 1,
        name: 'Sold Out Widget',
        quantityOnHand: 0,
        reorderThreshold: 2,
        unitCost: 10,
      );

      final result = ComputeDeadStockLiquidation.call(
        [emptyItem],
        const [],
        const [],
        now,
        const Duration(days: 90),
      );

      expect(result, isEmpty);
    });
  });
}
