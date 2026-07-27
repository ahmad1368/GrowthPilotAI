import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:objectbox/objectbox.dart';

/// Cancels an online-checkout hold (Issue #445), e.g. the session was
/// abandoned or expired, releasing the reserved quantity back to available
/// stock without ever touching [InventoryItemEntity.quantityOnHand].
class ReleaseStockReservation {
  static OmniResult<bool> call(Store store, int reservationId) async {
    final reservationBox = store.box<StockReservationEntity>();
    if (reservationBox.get(reservationId) == null) {
      return OmniResponse.error('Reservation not found.');
    }
    reservationBox.remove(reservationId);
    return OmniResponse.success(true);
  }
}
