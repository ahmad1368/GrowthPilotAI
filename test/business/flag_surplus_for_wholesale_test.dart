import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/flag_surplus_for_wholesale.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/dead_stock_liquidation_snapshot.dart';

void main() {
  test('lists the full on-hand quantity at the item unit cost, no markup', () {
    final item = InventoryItemEntity(
      id: 7,
      name: 'Canned Beans',
      quantityOnHand: 40,
      reorderThreshold: 5,
      unitCost: 2.50,
    );
    final snapshot = DeadStockLiquidationSnapshot(
      item: item,
      agingDays: 200,
      tiedUpCapital: 100,
      suggestedClearancePrice: 1.25,
      recoverableCapital: 50,
      suggestedChannel: 'Donation channel',
    );

    final listing = FlagSurplusForWholesale.call(snapshot, DateTime(2026, 1, 1));

    expect(listing.inventoryItemId, 7);
    expect(listing.itemName, 'Canned Beans');
    expect(listing.quantityListed, 40);
    expect(listing.wholesalePrice, 2.50);
  });
}
