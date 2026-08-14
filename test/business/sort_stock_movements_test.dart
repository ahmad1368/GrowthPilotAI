import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/sort_stock_movements.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

StockMovementEntity _movement(DateTime occurredAt, String itemName) {
  return StockMovementEntity(
      itemName: itemName, quantity: 1, resultingQuantityOnHand: 9, occurredAt: occurredAt);
}

void main() {
  test('sorts movements most-recent first', () {
    final results = SortStockMovements.call([
      _movement(DateTime(2026, 1, 1), 'old'),
      _movement(DateTime(2026, 1, 10), 'new'),
    ]);

    expect(results.map((m) => m.itemName), ['new', 'old']);
  });

  test('does not mutate the original list', () {
    final original = [
      _movement(DateTime(2026, 1, 1), 'old'),
      _movement(DateTime(2026, 1, 10), 'new'),
    ];
    SortStockMovements.call(original);

    expect(original.map((m) => m.itemName), ['old', 'new']);
  });
}
