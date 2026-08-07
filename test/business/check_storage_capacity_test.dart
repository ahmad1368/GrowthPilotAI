import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/check_storage_capacity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';

WholesaleListingEntity _listing(int quantity) {
  return WholesaleListingEntity(
    inventoryItemId: 1,
    itemName: 'Espresso Beans',
    quantityListed: quantity,
    wholesalePrice: 5,
    listedAt: DateTime(2026, 1, 1),
  );
}

void main() {
  test('fits within 3x the reorder threshold', () {
    expect(CheckStorageCapacity.call(_listing(30), 10), true);
  });

  test('does not fit beyond 3x the reorder threshold', () {
    expect(CheckStorageCapacity.call(_listing(31), 10), false);
  });

  test('defaults to fitting when there is no reorder threshold configured', () {
    expect(CheckStorageCapacity.call(_listing(9999), 0), true);
  });
}
