import 'package:growth_pilot_ai/business/build_audit_log_entry.dart';
import 'package:growth_pilot_ai/business/confirm_pre_order_fulfillment.dart';
import 'package:growth_pilot_ai/business/refund_pre_order_deposit.dart';
import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/features/analytics/widgets/pre_order_repos.dart';

/// Delivery confirmation and deposit refund/cancellation (Issue
/// #417, acceptance criterion 5) — split out of
/// [SeasonalCatalogBody].
class PreOrderFulfillmentActions {
  final PreOrderRepos repos;

  PreOrderFulfillmentActions(this.repos);

  PreOrderReservationEntity confirmFulfillment(PreOrderReservationEntity reservation) {
    final updated = ConfirmPreOrderFulfillment.call(reservation);
    repos.reservations.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'fulfilled seasonal pre-order',
      targetMerchant: reservation.merchantName,
      newValue: '${reservation.quantity} unit(s) delivered',
    ));
    return updated;
  }

  PreOrderReservationEntity refundDeposit(PreOrderReservationEntity reservation) {
    final updated = RefundPreOrderDeposit.call(reservation);
    repos.reservations.save(updated);
    repos.auditLogs.record(BuildAuditLogEntry.call(
      changeType: 'refunded pre-order deposit',
      targetMerchant: reservation.merchantName,
      newValue: '\$${reservation.depositAmount.toStringAsFixed(2)} refunded',
    ));
    return updated;
  }
}
