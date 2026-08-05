import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/asset_listing_status.dart';

/// A rapid liquidation listing for store equipment/fixtures (Issue
/// #412) — this app has no marketplace/escrow backend, so screening,
/// bidding, and pickup confirmation are all logged locally.
@Entity()
class AssetListingEntity {
  @Id()
  int id = 0;

  String sellerName;
  String assetName;
  String conditionDescription;
  double marketValue;
  double askingPrice;
  String commercialZone;
  int dbStatus; // AssetListingStatus index

  @Property(type: PropertyType.date)
  DateTime pickupDeadline;

  @Property(type: PropertyType.date)
  DateTime listedAt;

  AssetListingEntity({
    this.id = 0,
    required this.sellerName,
    required this.assetName,
    required this.conditionDescription,
    required this.marketValue,
    required this.askingPrice,
    required this.commercialZone,
    this.dbStatus = 0, // AssetListingStatus.pendingReview
    required this.pickupDeadline,
    required this.listedAt,
  });

  AssetListingStatus get status => AssetListingStatus.values[dbStatus];
  set status(AssetListingStatus value) => dbStatus = value.index;
}
