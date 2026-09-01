import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// A merchant's cumulative transaction count as of one order (Issue
/// #425, acceptance criterion 1) — counts that merchant's orders
/// placed at or before [order], so the tier evaluated at settlement
/// reflects the platform's full history with them, not a windowed
/// sample.
class ComputeCumulativeTransactionCount {
  static int call(WholesaleOrderEntity order, List<WholesaleOrderEntity> merchantOrders) {
    return merchantOrders.where((o) => !o.orderedAt.isAfter(order.orderedAt)).length;
  }
}
