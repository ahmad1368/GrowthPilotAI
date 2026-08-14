import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/catalog_availability.dart';
import 'package:growth_pilot_ai/core/enum/catalog_listing_type.dart';

/// Shared base fields of a Product or Service catalog listing (Issue
/// #138, acceptance criteria 1-3) — [attributesJson] is the dynamic
/// "Key-Value" attribute system, capped to 20 keys by
/// [CapAttributeKeys]. Owner contact stays unstored (never even a
/// field here) to satisfy the "Privacy Integrity" criterion.
@Entity()
class CatalogListingEntity {
  @Id()
  int id = 0;

  @Index()
  String ownerId;
  String title, description;
  @Index()
  String industry;
  String sector, category, tagsCsv;
  int dbListingType, dbAvailability;
  double locationLat, locationLng;
  String attributesJson, imageVariantIdsCsv;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  CatalogListingEntity({
    this.id = 0,
    required this.ownerId,
    required this.title,
    this.description = '',
    required this.industry,
    this.sector = '',
    this.category = '',
    this.tagsCsv = '',
    this.dbListingType = 0,
    this.dbAvailability = 0,
    this.locationLat = 0,
    this.locationLng = 0,
    this.attributesJson = '{}',
    this.imageVariantIdsCsv = '',
    required this.createdAt,
  });

  CatalogListingType get listingType => CatalogListingType.values[dbListingType];
  set listingType(CatalogListingType value) => dbListingType = value.index;
  CatalogAvailability get availability => CatalogAvailability.values[dbAvailability];
  set availability(CatalogAvailability value) => dbAvailability = value.index;
}
