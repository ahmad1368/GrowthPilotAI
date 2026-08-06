import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// Records the merchant settling the remaining balance ahead of the
/// seasonal delivery window (Issue #417, acceptance criterion 3).
class SettlePreOrderBalance {
  static PreOrderReservationEntity call(PreOrderReservationEntity reservation) {
    return PreOrderReservationEntity(
      id: reservation.id,
      catalogItemId: reservation.catalogItemId,
      merchantName: reservation.merchantName,
      quantity: reservation.quantity,
      depositAmount: reservation.depositAmount,
      dbStatus: PreOrderReservationStatus.balancePaid.index,
      reservedAt: reservation.reservedAt,
    );
  }
}
