import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// Marks a settled reservation delivered once the seasonal stock
/// arrives (Issue #417).
class ConfirmPreOrderFulfillment {
  static PreOrderReservationEntity call(PreOrderReservationEntity reservation) {
    return PreOrderReservationEntity(
      id: reservation.id,
      catalogItemId: reservation.catalogItemId,
      merchantName: reservation.merchantName,
      quantity: reservation.quantity,
      depositAmount: reservation.depositAmount,
      dbStatus: PreOrderReservationStatus.fulfilled.index,
      reservedAt: reservation.reservedAt,
    );
  }
}
