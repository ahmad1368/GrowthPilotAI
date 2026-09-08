import 'package:growth_pilot_ai/core/models/business_category.dart';

/// [Issue #826] Commerce-sector slice of the Canadian business taxonomy —
/// split out of canadian_business_categories.dart to stay under this
/// repo's per-file line cap.
const commerceBusinessCategories = <BusinessCategory>[
  BusinessCategory(id: 'retail', name: 'Retail Trade', children: [
    BusinessSubcategory(id: 'retail_grocery', name: 'Grocery & Convenience'),
    BusinessSubcategory(id: 'retail_clothing', name: 'Clothing & Accessories'),
    BusinessSubcategory(id: 'retail_electronics', name: 'Electronics'),
    BusinessSubcategory(id: 'retail_general', name: 'General Merchandise'),
  ]),
  BusinessCategory(id: 'food_service', name: 'Food & Beverage Services', children: [
    BusinessSubcategory(id: 'food_restaurant', name: 'Restaurant'),
    BusinessSubcategory(id: 'food_cafe', name: 'Cafe / Coffee Shop'),
    BusinessSubcategory(id: 'food_catering', name: 'Catering'),
    BusinessSubcategory(id: 'food_bar', name: 'Bar / Pub'),
  ]),
  BusinessCategory(id: 'professional_services', name: 'Professional Services', children: [
    BusinessSubcategory(id: 'prof_accounting', name: 'Accounting & Bookkeeping'),
    BusinessSubcategory(id: 'prof_legal', name: 'Legal Services'),
    BusinessSubcategory(id: 'prof_consulting', name: 'Consulting'),
    BusinessSubcategory(id: 'prof_marketing', name: 'Marketing & Advertising'),
  ]),
];
