import 'package:growth_pilot_ai/business/compute_available_quantity.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_reservation_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';

import '../../objectbox.g.dart';

/// Places a real-time lock on inventory for an active online-checkout
/// session (Issue #445). Wrapped in an [Store.runInTransaction] write, same
/// as [ApplyStockMovement], so a concurrent reservation or sale against the
/// same item re-reads a consistent state instead of both passing a stale
/// availability check.
class ReserveStockForCheckout {
  static OmniResult<StockReservationEntity> call(
      Store store, int itemId, int quantity) async {
    try {
      final itemBox = store.box<InventoryItemEntity>();
      final reservationBox = store.box<StockReservationEntity>();
      late StockReservationEntity reservation;

      store.runInTransaction(TxMode.write, () {
        final item = itemBox.get(itemId);
        if (item == null) throw StateError('Inventory item not found.');

        final query =
            reservationBox.query(StockReservationEntity_.itemId.equals(itemId)).build();
        final active = query.find();
        query.close();

        final available = ComputeAvailableQuantity.call(
            item.quantityOnHand, active.map((r) => r.quantityReserved).toList());
        if (quantity > available) throw StateError('Not enough stock available to reserve.');

        reservation = StockReservationEntity(
          itemId: itemId,
          itemName: item.name,
          quantityReserved: quantity,
          createdAt: DateTime.now(),
        );
        reservationBox.put(reservation);
      });

      return OmniResponse.success(reservation);
    } catch (e) {
      return OmniResponse.error(e.toString());
    }
  }
}
