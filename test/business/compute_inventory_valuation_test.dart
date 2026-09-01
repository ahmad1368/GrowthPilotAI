import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_inventory_valuation.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';

InventoryCostLayerEntity _layer(int quantity, double unitCost, DateTime receivedAt) {
  return InventoryCostLayerEntity(
      itemId: 1, itemName: 'Flour', quantity: quantity, unitCost: unitCost, receivedAt: receivedAt);
}

void main() {
  final oldLayer = _layer(10, 2.0, DateTime(2026, 1, 1));
  final newLayer = _layer(10, 4.0, DateTime(2026, 2, 1));
  final layers = [oldLayer, newLayer];

  test('FIFO values remaining stock at the most recent layers', () {
    // 15 on hand: assumes the 10 oldest units sold, 5 of the newest remain
    // plus... remaining stock is the newest layer's 10 units + 5 more only
    // exist in that layer, so this covers partial consumption of a layer.
    expect(ComputeInventoryValuation.call(5, layers, ValuationMethod.fifo), 20.0);
  });

  test('LIFO values remaining stock at the oldest layers', () {
    expect(ComputeInventoryValuation.call(5, layers, ValuationMethod.lifo), 10.0);
  });

  test('weighted average blends cost across all layers', () {
    // total cost 10*2 + 10*4 = 60 over 20 units = 3.0/unit
    expect(ComputeInventoryValuation.call(5, layers, ValuationMethod.weightedAverage), 15.0);
  });

  test('FIFO can span multiple layers when remaining exceeds one', () {
    expect(ComputeInventoryValuation.call(15, layers, ValuationMethod.fifo), 50.0);
  });

  test('zero quantity on hand values at zero', () {
    expect(ComputeInventoryValuation.call(0, layers, ValuationMethod.fifo), 0);
  });

  test('no cost layers values at zero', () {
    expect(ComputeInventoryValuation.call(5, const [], ValuationMethod.fifo), 0);
  });
}
