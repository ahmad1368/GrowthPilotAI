import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';
import 'package:growth_pilot_ai/core/models/stock_depletion_forecast.dart';

/// One AI-driven restocking suggestion (Issue #418): a critical
/// [forecast] item paired with a matching marketplace listing (if
/// any) and whether it currently fits the merchant's configured
/// budget/storage constraints.
@immutable
class InventoryRecommendation {
  final StockDepletionForecast forecast;
  final WholesaleListingEntity? matchedListing;
  final bool fitsBudget;
  final bool fitsStorage;

  const InventoryRecommendation({
    required this.forecast,
    required this.matchedListing,
    required this.fitsBudget,
    required this.fitsStorage,
  });
}
