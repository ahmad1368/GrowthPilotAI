import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// One zero-turnover item's liquidation plan (Issue #370).
class DeadStockLiquidationSnapshot {
  final InventoryItemEntity item;
  final int agingDays;
  final double tiedUpCapital;
  final double suggestedClearancePrice;
  final double recoverableCapital;
  final String suggestedChannel;

  const DeadStockLiquidationSnapshot({
    required this.item,
    required this.agingDays,
    required this.tiedUpCapital,
    required this.suggestedClearancePrice,
    required this.recoverableCapital,
    required this.suggestedChannel,
  });
}
