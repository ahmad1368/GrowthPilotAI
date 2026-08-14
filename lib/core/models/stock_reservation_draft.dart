import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

/// Not-yet-applied online-checkout reservation request from the
/// reserve-stock dialog (Issue #445): which item, how many units to hold.
class StockReservationDraft {
  final InventoryItemEntity item;
  final int quantity;

  const StockReservationDraft({required this.item, required this.quantity});
}
