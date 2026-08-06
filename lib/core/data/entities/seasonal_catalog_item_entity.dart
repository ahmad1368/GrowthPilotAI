import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/seasonal_catalog_status.dart';

/// A primary supplier's upcoming seasonal product line open for
/// advance pre-order at a preferential rate (Issue #417) — this app
/// has no live supplier-catalog feed, so a merchant publishes the
/// line manually, the same simplification the marketplace listings
/// in #412-#414 already use.
@Entity()
class SeasonalCatalogItemEntity {
  @Id()
  int id = 0;

  String supplierName;
  String productName;
  String productDescription;
  double unitPrice;
  double depositPercent;
  int dbStatus; // SeasonalCatalogStatus index

  @Property(type: PropertyType.date)
  DateTime deliveryWindowStart;

  @Property(type: PropertyType.date)
  DateTime listedAt;

  SeasonalCatalogItemEntity({
    this.id = 0,
    required this.supplierName,
    required this.productName,
    required this.productDescription,
    required this.unitPrice,
    required this.depositPercent,
    this.dbStatus = 0, // SeasonalCatalogStatus.open
    required this.deliveryWindowStart,
    required this.listedAt,
  });

  SeasonalCatalogStatus get status => SeasonalCatalogStatus.values[dbStatus];
  set status(SeasonalCatalogStatus value) => dbStatus = value.index;
}
