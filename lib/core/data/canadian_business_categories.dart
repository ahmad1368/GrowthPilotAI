import 'package:growth_pilot_ai/core/data/business_categories_commerce.dart';
import 'package:growth_pilot_ai/core/data/business_categories_other.dart';
import 'package:growth_pilot_ai/core/data/business_categories_trades.dart';
import 'package:growth_pilot_ai/core/models/business_category.dart';

/// [Issue #826] Representative (not exhaustive, not an official
/// classification) two-level taxonomy of Canadian business types, loosely
/// modeled on top-level NAICS sectors — a starting point for the profile's
/// business-type dropdowns, not a verified Statistics Canada NAICS list.
const canadianBusinessCategories = <BusinessCategory>[
  ...commerceBusinessCategories,
  ...tradesBusinessCategories,
  ...otherBusinessCategories,
];
