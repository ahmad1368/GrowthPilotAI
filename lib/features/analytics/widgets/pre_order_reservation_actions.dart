import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/reserve_pre_order.dart';
import 'package:growth_pilot_ai/business/settle_pre_order_balance.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/seasonal_catalog_item_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_repos.dart';

/// Reservation deposit and balance settlement (Issue #417, acceptance
/// criteria 2-3) — split out of [SeasonalCatalogBody].
class PreOrderReservationActions {
  final PreOrderRepos repos;

  PreOrderReservationActions(this.repos);

  void reserve(SeasonalCatalogItemEntity catalogItem, String merchantName, int quantity) {
    final reservation = ReservePreOrder.call(catalogItem, merchantName, quantity, DateTime.now());
    repos.reservations.save(reservation);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'reserved seasonal pre-order',
      targetMerchant: catalogItem.supplierName,
      newValue: '$merchantName reserved $quantity of ${catalogItem.productName} '
          '(deposit \$${reservation.depositAmount.toStringAsFixed(2)})',
    ));
  }

  PreOrderReservationEntity settleBalance(PreOrderReservationEntity reservation) {
    final updated = SettlePreOrderBalance.call(reservation);
    repos.reservations.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'settled pre-order balance',
      targetMerchant: reservation.merchantName,
      previousValue: 'depositPaid',
      newValue: 'balancePaid',
    ));
    return updated;
  }
}
