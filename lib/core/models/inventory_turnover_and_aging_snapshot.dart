import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// One item's turnover-and-aging result (Issue #447).
class InventoryTurnoverAndAgingSnapshot {
  final InventoryItemEntity item;
  final int salesUnits;
  final double turnoverRatio;
  final int agingDays;
  final String statusLabel;

  const InventoryTurnoverAndAgingSnapshot({
    required this.item,
    required this.salesUnits,
    required this.turnoverRatio,
    required this.agingDays,
    required this.statusLabel,
  });
}
