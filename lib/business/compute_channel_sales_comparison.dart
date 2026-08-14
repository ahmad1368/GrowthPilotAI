import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/channel_sales_snapshot.dart';

/// Per-channel (POS vs online) sales volume and estimated value
/// (Issue #384) — not the issue's literal fulfillment-cost/margin or
/// cross-channel customer-journey analysis, since this app tracks
/// neither fulfillment cost nor per-customer identity on stock movements.
class ComputeChannelSalesComparison {
  static List<ChannelSalesSnapshot> call(
    List<StockMovementEntity> movements,
    List<InventoryItemEntity> items,
  ) {
    final costByName = {
      for (final item in items) item.name.toLowerCase(): item.unitCost,
    };

    return [
      for (final channel in SalesChannel.values)
        _forChannel(movements, costByName, channel),
    ];
  }

  static ChannelSalesSnapshot _forChannel(
    List<StockMovementEntity> movements,
    Map<String, double> costByName,
    SalesChannel channel,
  ) {
    final sales = movements
        .where((m) => m.type == StockMovementType.sale && m.channel == channel);
    final unitsSold = sales.fold<int>(0, (sum, m) => sum + m.quantity);
    final estimatedRevenue = sales.fold<double>(
        0, (sum, m) => sum + m.quantity * (costByName[m.itemName.toLowerCase()] ?? 0));

    return ChannelSalesSnapshot(
      channel: channel,
      unitsSold: unitsSold,
      estimatedRevenue: estimatedRevenue,
    );
  }
}
