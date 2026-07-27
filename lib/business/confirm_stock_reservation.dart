import 'package:growth_pilot_ai/business/apply_stock_movement.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:objectbox/objectbox.dart';

/// Completes an online checkout (Issue #445): turns the reservation's held
/// quantity into a real committed sale in the same unified stock-movement
/// ledger the in-store register writes to, then releases the lock.
class ConfirmStockReservation {
  static OmniResult<StockMovementEntity> call(Store store, int reservationId) async {
    try {
      final reservationBox = store.box<StockReservationEntity>();
      final reservation = reservationBox.get(reservationId);
      if (reservation == null) throw StateError('Reservation not found.');

      final result = await ApplyStockMovement.call(
          store, reservation.itemId, reservation.quantityReserved, StockMovementType.sale,
          channel: SalesChannel.online);
      if (!result.success) return result;

      reservationBox.remove(reservationId);
      return result;
    } catch (e) {
      return OmniResponse.error(e.toString());
    }
  }
}
