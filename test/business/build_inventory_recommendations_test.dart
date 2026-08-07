import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/build_inventory_recommendations.dart';
import 'package:growth_pilot_ai/core/data/entities/inventory_item_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';

InventoryItemEntity _item(String name, int reorderThreshold) {
  return InventoryItemEntity(
      name: name, quantityOnHand: 2, reorderThreshold: reorderThreshold, unitCost: 5);
}

void main() {
  test('only critical forecasts become recommendations', () {
    final forecasts = [
      StockDepletionForecast(
          item: _item('Espresso Beans', 10),
          dailyVelocity: 2,
          daysUntilStockout: 5,
          isCritical: true),
      StockDepletionForecast(
          item: _item('Bar Stools', 10),
          dailyVelocity: 0.1,
          daysUntilStockout: 100,
          isCritical: false),
    ];

    final recommendations = BuildInventoryRecommendations.call(forecasts, [], []);

    expect(recommendations.length, 1);
    expect(recommendations.first.forecast.item.name, 'Espresso Beans');
    expect(recommendations.first.matchedListing, isNull);
    expect(recommendations.first.fitsBudget, true);
    expect(recommendations.first.fitsStorage, true);
  });

  test('pairs a critical item with its matching active listing', () {
    final forecasts = [
      StockDepletionForecast(
          item: _item('Espresso Beans', 10),
          dailyVelocity: 2,
          daysUntilStockout: 5,
          isCritical: true),
    ];
    final listings = [
      WholesaleListingEntity(
          inventoryItemId: 1,
          itemName: 'Espresso Beans',
          quantityListed: 15,
          wholesalePrice: 5,
          listedAt: DateTime(2026, 1, 1)),
    ];

    final recommendations = BuildInventoryRecommendations.call(forecasts, listings, []);

    expect(recommendations.first.matchedListing?.itemName, 'Espresso Beans');
  });
}
