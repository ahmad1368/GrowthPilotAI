import 'package:growth_pilot_ai/business/compute_stock_movement.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';
import 'package:growth_pilot_ai/core/models/omni_response.dart';
import 'package:objectbox/objectbox.dart';

/// Atomically decrements/restores an inventory item's quantity on hand and
/// logs the movement (Issue #439: real-time stock tracking engine). Wrapped
/// in a single [Store.runInTransaction] write so concurrent calls against
/// the same item serialize instead of racing — ObjectBox holds the write
/// lock for the whole callback, and [ComputeStockMovement]'s insufficient-
/// stock check re-reads the item inside that lock, so two simultaneous
/// sales can't both pass a stale check and oversell.
class ApplyStockMovement {
  static OmniResult<StockMovementEntity> call(
      Store store, int itemId, int quantity, StockMovementType type) async {
    try {
      final itemBox = store.box<InventoryItemEntity>();
      final movementBox = store.box<StockMovementEntity>();
      late StockMovementEntity movement;

      store.runInTransaction(TxMode.write, () {
        final item = itemBox.get(itemId);
        if (item == null) throw StateError('Inventory item not found.');

        final calc = ComputeStockMovement.call(item.quantityOnHand, quantity, type);
        if (!calc.isValid) throw StateError(calc.error!);

        item.quantityOnHand = calc.resultingQuantityOnHand!;
        itemBox.put(item);

        movement = StockMovementEntity(
          itemName: item.name,
          quantity: quantity,
          resultingQuantityOnHand: calc.resultingQuantityOnHand!,
          occurredAt: DateTime.now(),
        )..type = type;
        movementBox.put(movement);
      });

      return OmniResponse.success(movement);
    } catch (e) {
      return OmniResponse.error(e.toString());
    }
  }
}
