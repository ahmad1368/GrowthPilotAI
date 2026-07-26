import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_stock_take_variance.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';

InventoryStockTakeEntity _record(
        String name, int system, int physical, DateTime takenAt) =>
    InventoryStockTakeEntity(
        itemName: name, systemQuantity: system, physicalQuantity: physical, takenAt: takenAt);

void main() {
  test('a negative variance flags shrinkage', () {
    final results = ComputeStockTakeVariance.call([_record('Flour', 50, 45, DateTime(2026, 1, 1))]);
    expect(results.single.variance, -5);
    expect(results.single.hasDiscrepancy, isTrue);
  });

  test('a matching count has zero variance and no discrepancy', () {
    final results = ComputeStockTakeVariance.call([_record('Flour', 50, 50, DateTime(2026, 1, 1))]);
    expect(results.single.variance, 0);
    expect(results.single.hasDiscrepancy, isFalse);
  });

  test('a positive variance is a surplus', () {
    final results = ComputeStockTakeVariance.call([_record('Flour', 50, 55, DateTime(2026, 1, 1))]);
    expect(results.single.variance, 5);
  });

  test('sorts most-recent-first', () {
    final records = [
      _record('Old', 10, 10, DateTime(2026, 1, 1)),
      _record('New', 10, 10, DateTime(2026, 3, 1)),
      _record('Mid', 10, 10, DateTime(2026, 2, 1)),
    ];

    final results = ComputeStockTakeVariance.call(records);

    expect(results.map((r) => r.itemName), ['New', 'Mid', 'Old']);
  });

  test('no records returns an empty list', () {
    expect(ComputeStockTakeVariance.call([]), isEmpty);
  });
}
