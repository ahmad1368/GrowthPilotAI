import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_inventory_item_sku.dart';

void main() {
  test('uses the first 3 letters of the category name as the prefix', () {
    expect(GenerateInventoryItemSku.call('Bakery', []), 'BAK-0001');
  });

  test('falls back to GEN when there is no category', () {
    expect(GenerateInventoryItemSku.call(null, []), 'GEN-0001');
  });

  test('pads a short category name with X to reach 3 letters', () {
    expect(GenerateInventoryItemSku.call('Ox', []), 'OXX-0001');
  });

  test('increments past existing SKUs with the same prefix', () {
    final result = GenerateInventoryItemSku.call('Bakery', ['BAK-0001', 'BAK-0002']);
    expect(result, 'BAK-0003');
  });

  test('skips a collision even if the count-based guess is already taken', () {
    final result =
        GenerateInventoryItemSku.call('Bakery', ['BAK-0001', 'BAK-0002', 'BAK-0002']);
    expect(result, isNot('BAK-0002'));
    expect(['BAK-0001', 'BAK-0002', 'BAK-0002'].contains(result), isFalse);
  });

  test('ignores SKUs from a different prefix when counting', () {
    final result = GenerateInventoryItemSku.call('Bakery', ['DAI-0001', 'DAI-0002']);
    expect(result, 'BAK-0001');
  });
}
