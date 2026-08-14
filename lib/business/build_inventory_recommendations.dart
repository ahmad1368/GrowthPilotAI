import 'package:growth_pilot_ai/business/check_budget_fit.dart';
import 'package:growth_pilot_ai/business/check_storage_capacity.dart';
import 'package:growth_pilot_ai/business/match_recommendation_to_listing.dart';
import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_recommendation.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';

/// Turns critical stock-depletion forecasts (Issue #360) into
/// marketplace restocking recommendations (Issue #418, acceptance
/// criteria 1-2 and 5) — items with no imminent stockout risk aren't
/// "missing" yet, so they're excluded.
class BuildInventoryRecommendations {
  static List<InventoryRecommendation> call(
    List<StockDepletionForecast> forecasts,
    List<WholesaleListingEntity> listings,
    List<BudgetLimitEntity> budgetLimits,
  ) {
    return forecasts.where((f) => f.isCritical).map((forecast) {
      final matched = MatchRecommendationToListing.call(forecast.item.name, listings);
      final categoryName = forecast.item.category.target?.name;
      return InventoryRecommendation(
        forecast: forecast,
        matchedListing: matched,
        fitsBudget: matched == null || CheckBudgetFit.call(matched, categoryName, budgetLimits),
        fitsStorage:
            matched == null || CheckStorageCapacity.call(matched, forecast.item.reorderThreshold),
      );
    }).toList();
  }
}
