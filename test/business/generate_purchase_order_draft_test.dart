import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_purchase_order_draft.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';

InventoryItemEntity _item(String name, int quantity, int threshold, double unitCost) =>
    InventoryItemEntity(
        name: name, quantityOnHand: quantity, reorderThreshold: threshold, unitCost: unitCost);

void main() {
  test('returns null when nothing is low on stock', () {
    final draft = GeneratePurchaseOrderDraft.call([_item('Flour', 50, 10, 3.0)]);
    expect(draft, isNull);
  });

  test('suggests restocking to double the reorder threshold', () {
    final draft = GeneratePurchaseOrderDraft.call([_item('Flour', 4, 10, 3.0)]);
    // reorderThreshold*2 - quantityOnHand = 20 - 4 = 16
    expect(draft!.itemsSummary, 'Flour x16');
    expect(draft.estimatedTotal, 48.0);
  });

  test('excludes items above their reorder threshold', () {
    final draft = GeneratePurchaseOrderDraft.call([
      _item('Flour', 4, 10, 3.0),
      _item('Sugar', 50, 10, 2.0),
    ]);
    expect(draft!.itemsSummary, isNot(contains('Sugar')));
  });

  test('combines multiple low-stock items into one summary', () {
    final draft = GeneratePurchaseOrderDraft.call([
      _item('Flour', 4, 10, 3.0),
      _item('Butter', 2, 5, 6.0),
    ]);
    expect(draft!.itemsSummary, 'Flour x16, Butter x8');
  });
}
