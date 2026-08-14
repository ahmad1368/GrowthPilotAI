import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_inventory_turnover_and_aging.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  group('ComputeInventoryTurnoverAndAging', () {
    test('computes turnover ratio and aging from sales and receipts', () {
      final now = DateTime(2024, 2, 10);
      final item = InventoryItemEntity(
        id: 1,
        name: 'Widget',
        quantityOnHand: 5,
        reorderThreshold: 2,
        unitCost: 4,
      );
      final slowItem = InventoryItemEntity(
        id: 2,
        name: 'Slow Mover',
        quantityOnHand: 3,
        reorderThreshold: 1,
        unitCost: 6,
      );
      final movements = <StockMovementEntity>[
        StockMovementEntity(
          itemName: item.name,
          quantity: 6,
          resultingQuantityOnHand: 4,
          occurredAt: DateTime(2024, 1, 20),
          dbType: StockMovementType.sale.index,
        ),
        StockMovementEntity(
          itemName: slowItem.name,
          quantity: 1,
          resultingQuantityOnHand: 2,
          occurredAt: DateTime(2024, 1, 15),
          dbType: StockMovementType.sale.index,
        ),
      ];
      final layers = <InventoryCostLayerEntity>[
        InventoryCostLayerEntity(
          itemId: item.id,
          itemName: item.name,
          quantity: 10,
          unitCost: 3,
          receivedAt: DateTime(2024, 1, 1),
        ),
        InventoryCostLayerEntity(
          itemId: slowItem.id,
          itemName: slowItem.name,
          quantity: 3,
          unitCost: 8,
          receivedAt: DateTime(2023, 12, 30),
        ),
      ];

      final result = ComputeInventoryTurnoverAndAging.call(
        [item, slowItem],
        movements,
        layers,
        now,
        const Duration(days: 90),
      );

      expect(result.length, 2);
      expect(result.first.turnoverRatio, closeTo(1.2, 0.001));
      expect(result.first.agingDays, 40);
      expect(result.first.statusLabel, 'Fast moving');
      expect(result.last.turnoverRatio, closeTo(0.333, 0.001));
      expect(result.last.agingDays, 42);
      expect(result.last.statusLabel, 'Needs review');
      expect(result.first.item.name, 'Widget');
    });

    test('excludes sales outside the selected lookback period', () {
      final now = DateTime(2024, 2, 10);
      final item = InventoryItemEntity(
        id: 1,
        name: 'Widget',
        quantityOnHand: 5,
        reorderThreshold: 2,
        unitCost: 4,
      );
      final movements = <StockMovementEntity>[
        StockMovementEntity(
          itemName: item.name,
          quantity: 6,
          resultingQuantityOnHand: 4,
          occurredAt: DateTime(2023, 10, 1),
          dbType: StockMovementType.sale.index,
        ),
      ];

      final result = ComputeInventoryTurnoverAndAging.call(
        [item],
        movements,
        const [],
        now,
        const Duration(days: 30),
      );

      expect(result.single.salesUnits, 0);
      expect(result.single.turnoverRatio, 0.0);
    });
  });
}
