import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

/// The Service discriminator's extra fields (Issue #138, acceptance
/// criterion 2) — linked back to its [CatalogListingEntity] by
/// [listingId] instead of a Mongoose discriminator.
@Entity()
class ServiceListingDetailsEntity {
  @Id()
  int id = 0;

  @Index()
  int listingId;

  double hourlyRate;
  int durationEstimateMinutes;
  double serviceRadiusKm;
  bool certificationRequired;
  int dbPricingMode;
  double fixedPrice, priceRangeMin, priceRangeMax;

  ServiceListingDetailsEntity({
    this.id = 0,
    required this.listingId,
    this.hourlyRate = 0,
    this.durationEstimateMinutes = 0,
    this.serviceRadiusKm = 0,
    this.certificationRequired = false,
    this.dbPricingMode = 0,
    this.fixedPrice = 0,
    this.priceRangeMin = 0,
    this.priceRangeMax = 0,
  });

  CatalogPricingMode get pricingMode => CatalogPricingMode.values[dbPricingMode];
  set pricingMode(CatalogPricingMode value) => dbPricingMode = value.index;
}
