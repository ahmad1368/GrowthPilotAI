import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/catalog_pricing_mode.dart';

/// The Product discriminator's extra fields (Issue #138, acceptance
/// criterion 2) — linked back to its [CatalogListingEntity] by
/// [listingId] instead of a Mongoose discriminator.
@Entity()
class ProductListingDetailsEntity {
  @Id()
  int id = 0;

  @Index()
  int listingId;

  String sku;
  int stockLevel;
  double weightKg;
  int dbPricingMode;
  double fixedPrice, priceRangeMin, priceRangeMax;

  ProductListingDetailsEntity({
    this.id = 0,
    required this.listingId,
    this.sku = '',
    this.stockLevel = 0,
    this.weightKg = 0,
    this.dbPricingMode = 0,
    this.fixedPrice = 0,
    this.priceRangeMin = 0,
    this.priceRangeMax = 0,
  });

  CatalogPricingMode get pricingMode => CatalogPricingMode.values[dbPricingMode];
  set pricingMode(CatalogPricingMode value) => dbPricingMode = value.index;
}
