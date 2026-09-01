import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_channel_sales_narrative.dart';
import 'package:growth_pilot_ai/business/compute_channel_sales_comparison.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

void main() {
  final items = [
    InventoryItemEntity(
        id: 1, name: 'A', quantityOnHand: 5, reorderThreshold: 1, unitCost: 10),
    InventoryItemEntity(
        id: 2, name: 'B', quantityOnHand: 5, reorderThreshold: 1, unitCost: 20),
  ];

  final movements = [
    StockMovementEntity(
      itemName: 'A',
      quantity: 1,
      resultingQuantityOnHand: 4,
      occurredAt: DateTime(2024, 1, 1),
      dbType: StockMovementType.sale.index,
      dbChannel: SalesChannel.pos.index,
    ),
    StockMovementEntity(
      itemName: 'B',
      quantity: 2,
      resultingQuantityOnHand: 3,
      occurredAt: DateTime(2024, 1, 2),
      dbType: StockMovementType.sale.index,
      dbChannel: SalesChannel.online.index,
    ),
  ];

  group('ComputeChannelSalesComparison', () {
    test('aggregates units and estimated revenue per channel', () {
      final snapshots = ComputeChannelSalesComparison.call(movements, items);

      expect(snapshots.length, 2);
      final pos = snapshots.firstWhere((s) => s.channel == SalesChannel.pos);
      final online =
          snapshots.firstWhere((s) => s.channel == SalesChannel.online);

      expect(pos.unitsSold, 1);
      expect(pos.estimatedRevenue, 10);
      expect(online.unitsSold, 2);
      expect(online.estimatedRevenue, 40);
    });

    test('ignores non-sale movements', () {
      final returned = StockMovementEntity(
        itemName: 'A',
        quantity: 5,
        resultingQuantityOnHand: 9,
        occurredAt: DateTime(2024, 1, 3),
        dbType: StockMovementType.returnStock.index,
        dbChannel: SalesChannel.pos.index,
      );

      final snapshots =
          ComputeChannelSalesComparison.call([...movements, returned], items);
      final pos = snapshots.firstWhere((s) => s.channel == SalesChannel.pos);
      expect(pos.unitsSold, 1);
    });
  });

  group('BuildChannelSalesNarrative', () {
    test('falls back when there is no sale history', () {
      final snapshots = ComputeChannelSalesComparison.call(const [], items);
      expect(BuildChannelSalesNarrative.call(snapshots),
          contains('Not enough sale history'));
    });

    test('names the leading channel and its revenue share', () {
      final snapshots = ComputeChannelSalesComparison.call(movements, items);
      final narrative = BuildChannelSalesNarrative.call(snapshots);
      expect(narrative, contains('Online'));
      expect(narrative, contains('80%'));
    });
  });
}
