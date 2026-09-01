import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/check_budget_fit.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';

void main() {
  final listing = WholesaleListingEntity(
    inventoryItemId: 1,
    itemName: 'Espresso Beans',
    quantityListed: 10,
    wholesalePrice: 5,
    listedAt: DateTime(2026, 1, 1),
  );

  test('fits when the total cost is within the category limit', () {
    final limits = [BudgetLimitEntity(categoryName: 'Beverages', monthlyLimit: 100)];
    expect(CheckBudgetFit.call(listing, 'Beverages', limits), true);
  });

  test('does not fit when the total cost exceeds the category limit', () {
    final limits = [BudgetLimitEntity(categoryName: 'Beverages', monthlyLimit: 20)];
    expect(CheckBudgetFit.call(listing, 'Beverages', limits), false);
  });

  test('defaults to fitting when the category has no configured limit', () {
    expect(CheckBudgetFit.call(listing, 'Uncategorized', []), true);
  });

  test('defaults to fitting when the item has no category at all', () {
    expect(CheckBudgetFit.call(listing, null, [BudgetLimitEntity(categoryName: 'X', monthlyLimit: 1)]),
        true);
  });
}
