import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// Identifies a merchant's inaugural marketplace transaction (Issue
/// #420, acceptance criterion 1) — the earliest order chronologically
/// among all this device's orders for that merchant.
class IsFirstMarketplaceTransaction {
  static bool call(WholesaleOrderEntity order, List<WholesaleOrderEntity> merchantOrders) {
    if (merchantOrders.isEmpty) return true;
    final earliest =
        merchantOrders.reduce((a, b) => a.orderedAt.isBefore(b.orderedAt) ? a : b);
    return order.id == earliest.id;
  }
}
