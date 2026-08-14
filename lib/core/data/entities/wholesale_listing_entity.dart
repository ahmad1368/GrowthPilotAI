import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/wholesale_listing_status.dart';

/// A merchant's dead-stock item listed for B2B wholesale clearance
/// (Issue #411) — this app has no B2B marketplace backend, so listings
/// are logged locally at the item's own [InventoryItemEntity.unitCost]
/// as the wholesale acquisition-price baseline (acceptance criterion
/// 1), the same local-logging pattern [AdvertisingRequestEntity] (#401)
/// uses.
@Entity()
class WholesaleListingEntity {
  @Id()
  int id = 0;

  @Index()
  int inventoryItemId;

  String itemName;
  int quantityListed;
  double wholesalePrice;
  int dbStatus; // WholesaleListingStatus index

  @Property(type: PropertyType.date)
  DateTime listedAt;

  WholesaleListingEntity({
    this.id = 0,
    required this.inventoryItemId,
    required this.itemName,
    required this.quantityListed,
    required this.wholesalePrice,
    this.dbStatus = 0, // WholesaleListingStatus.active
    required this.listedAt,
  });

  WholesaleListingStatus get status => WholesaleListingStatus.values[dbStatus];
  set status(WholesaleListingStatus value) => dbStatus = value.index;
}
