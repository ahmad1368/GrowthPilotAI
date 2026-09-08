import 'package:growth_pilot_ai/core/models/business_category.dart';

/// [Issue #826] Trades/production-sector slice of the Canadian business
/// taxonomy — split out of canadian_business_categories.dart to stay
/// under this repo's per-file line cap.
const tradesBusinessCategories = <BusinessCategory>[
  BusinessCategory(id: 'construction', name: 'Construction & Trades', children: [
    BusinessSubcategory(id: 'const_general', name: 'General Contracting'),
    BusinessSubcategory(id: 'const_electrical', name: 'Electrical'),
    BusinessSubcategory(id: 'const_plumbing', name: 'Plumbing'),
    BusinessSubcategory(id: 'const_landscaping', name: 'Landscaping'),
  ]),
  BusinessCategory(id: 'health_wellness', name: 'Health & Wellness', children: [
    BusinessSubcategory(id: 'health_clinic', name: 'Clinic / Medical Practice'),
    BusinessSubcategory(id: 'health_dental', name: 'Dental'),
    BusinessSubcategory(id: 'health_fitness', name: 'Fitness & Gym'),
    BusinessSubcategory(id: 'health_spa', name: 'Spa & Beauty'),
  ]),
  BusinessCategory(id: 'manufacturing', name: 'Manufacturing', children: [
    BusinessSubcategory(id: 'mfg_food', name: 'Food Processing'),
    BusinessSubcategory(id: 'mfg_textile', name: 'Textiles & Apparel'),
    BusinessSubcategory(id: 'mfg_furniture', name: 'Furniture & Fixtures'),
  ]),
];
