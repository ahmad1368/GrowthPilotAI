import 'package:growth_pilot_ai/core/data/entities/budget_limit_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/wholesale_listing_entity.dart';

/// Whether a matched listing's total cost fits the merchant's
/// configured monthly budget for the item's category (Issue #418,
/// acceptance criterion 5) — an unconfigured category has no limit to
/// violate, so it defaults to fitting.
class CheckBudgetFit {
  static bool call(WholesaleListingEntity listing, String? categoryName,
      List<BudgetLimitEntity> budgetLimits) {
    if (categoryName == null) return true;
    final limit = budgetLimits
        .where((b) => b.categoryName.toLowerCase() == categoryName.toLowerCase())
        .firstOrNull;
    if (limit == null) return true;
    return listing.wholesalePrice * listing.quantityListed <= limit.monthlyLimit;
  }
}
