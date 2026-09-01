import 'package:growth_pilot_ai/business/compute_pre_order_balance.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';

/// Locks in a stock allocation via a fractional upfront deposit
/// (Issue #417, acceptance criterion 2) — pure construction, the
/// caller persists it.
class ReservePreOrder {
  static PreOrderReservationEntity call(
      SeasonalCatalogItemEntity catalogItem, String merchantName, int quantity, DateTime now) {
    final balance = ComputePreOrderBalance.call(catalogItem, quantity);
    return PreOrderReservationEntity(
      catalogItemId: catalogItem.id,
      merchantName: merchantName,
      quantity: quantity,
      depositAmount: balance.depositAmount,
      reservedAt: now,
    );
  }
}
