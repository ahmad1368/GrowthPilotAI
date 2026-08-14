import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/compute_stock_depletion_forecast.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

StockMovementEntity _sale(String itemName, int quantity, DateTime occurredAt) =>
    StockMovementEntity(
      itemName: itemName,
      quantity: quantity,
      resultingQuantityOnHand: 0,
      occurredAt: occurredAt,
      dbType: StockMovementType.sale.index,
    );

void main() {
  final now = DateTime(2024, 2, 10);

  group('ComputeStockDepletionForecast', () {
    test('projects days until stockout from recent sales velocity', () {
      final soonToRunOut = InventoryItemEntity(
          id: 1, name: 'Soon', quantityOnHand: 10, reorderThreshold: 2, unitCost: 5);
      final wellStocked = InventoryItemEntity(
          id: 2, name: 'Stocked', quantityOnHand: 100, reorderThreshold: 2, unitCost: 5);
      final movements = [
        _sale('Soon', 30, now.subtract(const Duration(days: 15))),
        _sale('Stocked', 30, now.subtract(const Duration(days: 15))),
      ];

      final forecasts = ComputeStockDepletionForecast.call(
          [soonToRunOut, wellStocked], movements, now, const Duration(days: 30));

      final soon = forecasts.firstWhere((f) => f.item.name == 'Soon');
      final stocked = forecasts.firstWhere((f) => f.item.name == 'Stocked');

      expect(soon.daysUntilStockout, closeTo(10, 1e-9));
      expect(soon.isCritical, isTrue);
      expect(stocked.daysUntilStockout, closeTo(100, 1e-9));
      expect(stocked.isCritical, isFalse);
    });

    test('returns a null ETA for items with no sales in the period', () {
      final idle = InventoryItemEntity(
          id: 1, name: 'Idle', quantityOnHand: 5, reorderThreshold: 2, unitCost: 5);

      final forecasts = ComputeStockDepletionForecast.call(
          [idle], const [], now, const Duration(days: 30));

      expect(forecasts.single.daysUntilStockout, isNull);
      expect(forecasts.single.isCritical, isFalse);
    });

    test('sorts soonest stock-out first, with no-trend items last', () {
      final soon = InventoryItemEntity(
          id: 1, name: 'Soon', quantityOnHand: 10, reorderThreshold: 2, unitCost: 5);
      final later = InventoryItemEntity(
          id: 2, name: 'Later', quantityOnHand: 100, reorderThreshold: 2, unitCost: 5);
      final idle = InventoryItemEntity(
          id: 3, name: 'Idle', quantityOnHand: 5, reorderThreshold: 2, unitCost: 5);
      final movements = [
        _sale('Soon', 30, now.subtract(const Duration(days: 15))),
        _sale('Later', 30, now.subtract(const Duration(days: 15))),
      ];

      final forecasts = ComputeStockDepletionForecast.call(
          [later, idle, soon], movements, now, const Duration(days: 30));

      expect(forecasts.map((f) => f.item.name).toList(), ['Soon', 'Later', 'Idle']);
    });
  });
}
