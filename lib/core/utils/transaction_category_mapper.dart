import 'package:growth_pilot_ai/core/enum/business_category.dart';

/// Normalizes raw Plaid category strings into the internal B2B taxonomy.
/// Unknown or missing categories fall back to [BusinessCategory.uncategorized].
class TransactionCategoryMapper {
  static const Map<String, BusinessCategory> _map = {
    'office supplies': BusinessCategory.officeSupplies,
    'shops': BusinessCategory.officeSupplies,
    'rent': BusinessCategory.rent,
    'utilities': BusinessCategory.utilities,
    'travel': BusinessCategory.travel,
    'food and drink': BusinessCategory.meals,
    'restaurants': BusinessCategory.meals,
    'software': BusinessCategory.software,
    'service': BusinessCategory.software,
  };

  static BusinessCategory fromPlaid(String? raw) {
    if (raw == null) return BusinessCategory.uncategorized;
    return _map[raw.trim().toLowerCase()] ?? BusinessCategory.uncategorized;
  }
}
