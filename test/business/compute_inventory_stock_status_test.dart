import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_inventory_expiry_status.dart';
import 'package:growth_pilot_ai/business/compute_inventory_stock_status.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_item.dart';

final _now = DateTime(2026, 6, 15);

InventoryItemEntity _item(String name, int quantity, int threshold, {double unitCost = 10}) =>
    InventoryItemEntity(
        name: name, quantityOnHand: quantity, reorderThreshold: threshold, unitCost: unitCost);

void main() {
  test('flags an item at or below its reorder threshold as low stock', () {
    final results = ComputeInventoryStockStatus.call([_item('Flour', 5, 10)], _now);
    expect(results.single.status, InventoryStockStatus.lowStock);
  });

  test('an item exactly at its threshold is still low stock', () {
    final results = ComputeInventoryStockStatus.call([_item('Sugar', 10, 10)], _now);
    expect(results.single.status, InventoryStockStatus.lowStock);
  });

  test('an item above its threshold is ok', () {
    final results = ComputeInventoryStockStatus.call([_item('Butter', 50, 10)], _now);
    expect(results.single.status, InventoryStockStatus.ok);
  });

  test('sorts by lowest quantity on hand first', () {
    final items = [
      _item('High', 100, 10),
      _item('Low', 2, 10),
      _item('Mid', 30, 10),
    ];

    final results = ComputeInventoryStockStatus.call(items, _now);

    expect(results.map((r) => r.name), ['Low', 'Mid', 'High']);
  });

  test('no items returns an empty list', () {
    expect(ComputeInventoryStockStatus.call([], _now), isEmpty);
  });

  test('carries an unset expiry date through as InventoryExpiryStatus.none', () {
    final results = ComputeInventoryStockStatus.call([_item('Flour', 50, 10)], _now);
    expect(results.single.expiryStatus, InventoryExpiryStatus.none);
  });

  test('classifies an item past its expiry date as expired with a matching label', () {
    final item = _item('Milk', 50, 10)..expiryDate = _now.subtract(const Duration(days: 1));
    final results = ComputeInventoryStockStatus.call([item], _now);
    expect(results.single.expiryStatus, InventoryExpiryStatus.expired);
    expect(results.single.expiryLabel, '1d expired');
  });

  test('leaves the expiry label null for an item with no expiry risk', () {
    final results = ComputeInventoryStockStatus.call([_item('Flour', 50, 10)], _now);
    expect(results.single.expiryLabel, isNull);
  });

  test('carries the serial number through', () {
    final item = _item('Drill', 50, 10)..serialNumber = 'SN-123';
    final results = ComputeInventoryStockStatus.call([item], _now);
    expect(results.single.serialNumber, 'SN-123');
  });
}
