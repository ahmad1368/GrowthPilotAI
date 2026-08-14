import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

/// Groups sale movements into "baskets" by exact sale timestamp (Issue
/// #378) — this app has no order/basket id linking multiple item sales
/// together, so items logged at the same instant stand in for one
/// checkout event. Single-item baskets are dropped since they can't
/// contribute to a co-purchase pair.
class GroupStockMovementsIntoBaskets {
  static List<List<String>> call(List<StockMovementEntity> movements) {
    final byTimestamp = <DateTime, List<String>>{};
    for (final m in movements) {
      if (m.type != StockMovementType.sale) continue;
      byTimestamp.putIfAbsent(m.occurredAt, () => []).add(m.itemName);
    }
    return byTimestamp.values.where((items) => items.toSet().length >= 2).toList();
  }
}
