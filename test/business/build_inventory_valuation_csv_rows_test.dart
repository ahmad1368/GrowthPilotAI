import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_inventory_valuation_csv_rows.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/models/item_valuation.dart';

void main() {
  test('maps each valuation to a CSV-ready row', () {
    final item = InventoryItemEntity(
        name: 'Flour', quantityOnHand: 5, reorderThreshold: 1, unitCost: 2);
    final valuation = ItemValuation(item: item, totalValue: 10.0);

    final rows = BuildInventoryValuationCsvRows.call([valuation]);

    expect(rows.single, {'item': 'Flour', 'quantityOnHand': 5, 'totalValue': 10.0});
  });

  test('no valuations produces no rows', () {
    expect(BuildInventoryValuationCsvRows.call(const []), isEmpty);
  });
}
