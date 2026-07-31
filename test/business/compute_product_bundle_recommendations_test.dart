import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_item_co_occurrence_counts.dart';
import 'package:growth_pilot_ai/business/compute_product_bundle_recommendations.dart';
import 'package:growth_pilot_ai/business/group_stock_movements_into_baskets.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

StockMovementEntity _sale(String itemName, DateTime occurredAt) =>
    StockMovementEntity(
      itemName: itemName,
      quantity: 1,
      resultingQuantityOnHand: 1,
      occurredAt: occurredAt,
      dbType: StockMovementType.sale.index,
    );

void main() {
  final t1 = DateTime(2024, 1, 1, 10);
  final t2 = DateTime(2024, 1, 1, 11);
  final t3 = DateTime(2024, 1, 1, 12);
  final t4 = DateTime(2024, 1, 1, 13);

  final movements = [
    _sale('A', t1), _sale('B', t1),
    _sale('A', t2), _sale('B', t2),
    _sale('A', t3), _sale('C', t3),
    _sale('A', t4), // single-item basket, dropped
  ];

  group('GroupStockMovementsIntoBaskets', () {
    test('groups sales by exact timestamp and drops single-item baskets', () {
      final baskets = GroupStockMovementsIntoBaskets.call(movements);
      expect(baskets.length, 3);
      expect(baskets.every((b) => b.toSet().length >= 2), isTrue);
    });
  });

  group('ComputeItemCoOccurrenceCounts', () {
    test('counts each unordered pair once per basket', () {
      final baskets = GroupStockMovementsIntoBaskets.call(movements);
      final counts = ComputeItemCoOccurrenceCounts.call(baskets);
      expect(counts['A::B'], 2);
      expect(counts['A::C'], 1);
    });
  });

  group('ComputeProductBundleRecommendations', () {
    test('filters below the co-occurrence threshold and prices the bundle',
        () {
      final items = [
        InventoryItemEntity(
            id: 1, name: 'A', quantityOnHand: 5, reorderThreshold: 1, unitCost: 10),
        InventoryItemEntity(
            id: 2, name: 'B', quantityOnHand: 5, reorderThreshold: 1, unitCost: 20),
        InventoryItemEntity(
            id: 3, name: 'C', quantityOnHand: 5, reorderThreshold: 1, unitCost: 5),
      ];

      final recommendations =
          ComputeProductBundleRecommendations.call(movements, items);

      expect(recommendations.length, 1);
      final top = recommendations.single;
      expect(top.itemA, 'A');
      expect(top.itemB, 'B');
      expect(top.coOccurrenceCount, 2);
      expect(top.supportRatio, closeTo(2 / 3, 1e-9));
      expect(top.combinedBasePrice, 30);
      expect(top.suggestedBundlePrice, closeTo(27, 1e-9));
      expect(top.discountAmount, closeTo(3, 1e-9));
    });

    test('returns no recommendations with no co-purchase history', () {
      final recommendations =
          ComputeProductBundleRecommendations.call(const [], const []);
      expect(recommendations, isEmpty);
    });
  });
}
