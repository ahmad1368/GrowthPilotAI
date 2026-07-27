import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_valuation_trend.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';

InventoryCostLayerEntity _layer(int quantity, double unitCost, DateTime receivedAt) {
  return InventoryCostLayerEntity(
      itemId: 1, itemName: 'Flour', quantity: quantity, unitCost: unitCost, receivedAt: receivedAt);
}

void main() {
  test('accumulates layer cost in chronological order regardless of input order', () {
    final layers = [
      _layer(10, 4.0, DateTime(2026, 2, 1)),
      _layer(10, 2.0, DateTime(2026, 1, 1)),
    ];

    final trend = BuildValuationTrend.call(layers);

    expect(trend[0].receivedAt, DateTime(2026, 1, 1));
    expect(trend[0].cumulativeValue, 20.0);
    expect(trend[1].receivedAt, DateTime(2026, 2, 1));
    expect(trend[1].cumulativeValue, 60.0);
  });

  test('no layers produces an empty trend', () {
    expect(BuildValuationTrend.call(const []), isEmpty);
  });
}
