import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_stock_movement.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  test('a sale decrements the resulting quantity on hand', () {
    final result = ComputeStockMovement.call(10, 4, StockMovementType.sale);

    expect(result.isValid, isTrue);
    expect(result.resultingQuantityOnHand, 6);
  });

  test('a return increments the resulting quantity on hand', () {
    final result = ComputeStockMovement.call(10, 5, StockMovementType.returnStock);

    expect(result.isValid, isTrue);
    expect(result.resultingQuantityOnHand, 15);
  });

  test('a sale that exactly empties stock is valid', () {
    final result = ComputeStockMovement.call(4, 4, StockMovementType.sale);

    expect(result.isValid, isTrue);
    expect(result.resultingQuantityOnHand, 0);
  });

  test('a sale exceeding stock on hand is rejected', () {
    final result = ComputeStockMovement.call(3, 4, StockMovementType.sale);

    expect(result.isValid, isFalse);
    expect(result.resultingQuantityOnHand, isNull);
    expect(result.error, 'Not enough stock on hand.');
  });
}
