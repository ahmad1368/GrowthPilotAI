import 'package:growth_pilot_ai/core/data/entities/wholesale_order_entity.dart';

/// Defaults a merchant's trial start to their earliest wholesale order
/// (Issue #424) — the platform-dependency clock starts running from
/// first real marketplace activity, not from an arbitrary admin entry
/// date, unless one hasn't happened yet.
class DeriveTrialStartDate {
  static DateTime call(
    String merchantName,
    List<WholesaleOrderEntity> orders,
    DateTime fallback,
  ) {
    final merchantOrders = orders.where((o) => o.buyerMerchantName == merchantName);
    if (merchantOrders.isEmpty) return fallback;
    return merchantOrders.map((o) => o.orderedAt).reduce((a, b) => a.isBefore(b) ? a : b);
  }
}
