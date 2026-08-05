import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/asset_bid_status.dart';

/// One buyer's binding bid on an asset listing (Issue #412, acceptance
/// criterion 3).
@Entity()
class AssetBidEntity {
  @Id()
  int id = 0;

  @Index()
  int listingId;

  String bidderName;
  double bidAmount;
  int dbStatus; // AssetBidStatus index

  @Property(type: PropertyType.date)
  DateTime submittedAt;

  AssetBidEntity({
    this.id = 0,
    required this.listingId,
    required this.bidderName,
    required this.bidAmount,
    this.dbStatus = 0, // AssetBidStatus.pending
    required this.submittedAt,
  });

  AssetBidStatus get status => AssetBidStatus.values[dbStatus];
  set status(AssetBidStatus value) => dbStatus = value.index;
}
