import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// Counts how many wholesale orders one merchant placed within the
/// recent tracking window (Issue #424, acceptance criterion 1) — the
/// "frequent order placement volume" dependency signal.
class ComputeOrderPlacementVolume {
  static const windowDays = 90;

  static int call(
    String merchantName,
    List<WholesaleOrderEntity> orders,
    DateTime now,
  ) {
    final cutoff = now.subtract(const Duration(days: windowDays));
    return orders
        .where((o) => o.buyerMerchantName == merchantName && !o.orderedAt.isBefore(cutoff))
        .length;
  }
}
