import 'package:growth_pilot_ai/core/models/business_category.dart';

/// [Issue #826] Remaining sectors of the Canadian business taxonomy —
/// split out of canadian_business_categories.dart to stay under this
/// repo's per-file line cap.
const otherBusinessCategories = <BusinessCategory>[
  BusinessCategory(id: 'technology', name: 'Technology', children: [
    BusinessSubcategory(id: 'tech_software', name: 'Software Development'),
    BusinessSubcategory(id: 'tech_it_services', name: 'IT Services & Support'),
    BusinessSubcategory(id: 'tech_ecommerce', name: 'E-commerce'),
  ]),
  BusinessCategory(id: 'transportation', name: 'Transportation & Logistics', children: [
    BusinessSubcategory(id: 'trans_trucking', name: 'Trucking & Freight'),
    BusinessSubcategory(id: 'trans_courier', name: 'Courier & Delivery'),
    BusinessSubcategory(id: 'trans_taxi', name: 'Taxi / Rideshare'),
  ]),
  BusinessCategory(id: 'real_estate', name: 'Real Estate', children: [
    BusinessSubcategory(id: 're_agency', name: 'Real Estate Agency'),
    BusinessSubcategory(id: 're_property_mgmt', name: 'Property Management'),
  ]),
  BusinessCategory(id: 'other', name: 'Other', children: [
    BusinessSubcategory(id: 'other_misc', name: 'Other'),
  ]),
];
