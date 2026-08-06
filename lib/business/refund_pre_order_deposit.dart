import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// Cancels a reservation before fulfillment and refunds the deposit
/// (Issue #417, acceptance criterion 5) — this app has no
/// payment-processing backend, so "refund" is this status transition
/// plus the caller's audit log entry, not a real funds transfer.
class RefundPreOrderDeposit {
  static PreOrderReservationEntity call(PreOrderReservationEntity reservation) {
    return PreOrderReservationEntity(
      id: reservation.id,
      catalogItemId: reservation.catalogItemId,
      merchantName: reservation.merchantName,
      quantity: reservation.quantity,
      depositAmount: reservation.depositAmount,
      dbStatus: PreOrderReservationStatus.refunded.index,
      reservedAt: reservation.reservedAt,
    );
  }
}
