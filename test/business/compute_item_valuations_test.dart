import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_item_valuations.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';

void main() {
  test('values each item against only its own cost layers', () {
    final flour = InventoryItemEntity(
        id: 1, name: 'Flour', quantityOnHand: 5, reorderThreshold: 1, unitCost: 2);
    final sugar = InventoryItemEntity(
        id: 2, name: 'Sugar', quantityOnHand: 4, reorderThreshold: 1, unitCost: 3);
    final layers = [
      InventoryCostLayerEntity(
          itemId: 1, itemName: 'Flour', quantity: 5, unitCost: 2, receivedAt: DateTime(2026, 1, 1)),
      InventoryCostLayerEntity(
          itemId: 2, itemName: 'Sugar', quantity: 4, unitCost: 3, receivedAt: DateTime(2026, 1, 1)),
    ];

    final result =
        ComputeItemValuations.call([flour, sugar], layers, ValuationMethod.weightedAverage);

    expect(result[0].totalValue, 10.0);
    expect(result[1].totalValue, 12.0);
  });

  test('an item with no cost layers values at zero', () {
    final item = InventoryItemEntity(
        id: 1, name: 'Flour', quantityOnHand: 5, reorderThreshold: 1, unitCost: 2);

    final result = ComputeItemValuations.call([item], const [], ValuationMethod.fifo);

    expect(result.single.totalValue, 0);
  });
}
