import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/asset_custody_status.dart';

/// One immutable custody hand-off for a physical asset (Issue #157: "Asset
/// Custody Logic"), snapshotting the asset's status at transfer time — same
/// event-sourced approach as StockMovementEntity (#439) rather than
/// mutating a "current custodian" field in place.
@Entity()
class AssetCustodyRecordEntity {
  @Id()
  int id = 0;

  @Index()
  String itemName;

  String fromCustodianId;

  String toCustodianId;

  int dbStatus;

  @Index()
  @Property(type: PropertyType.date)
  DateTime transferredAt;

  AssetCustodyRecordEntity({
    this.id = 0,
    required this.itemName,
    required this.fromCustodianId,
    required this.toCustodianId,
    required this.transferredAt,
    this.dbStatus = 0,
  });

  AssetCustodyStatus get statusAtTransfer => AssetCustodyStatus.values[dbStatus];
  set statusAtTransfer(AssetCustodyStatus value) => dbStatus = value.index;
}
