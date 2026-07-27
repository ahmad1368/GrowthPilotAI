import 'package:objectbox/objectbox.dart';

/// Direction of a stock movement (Issue #439): [sale] decrements quantity
/// on hand, [returnStock] restores it.
enum StockMovementType { sale, returnStock }

/// Origin of a stock movement or reservation (Issue #445): unifies the
/// in-store register and the online storefront in one ledger.
enum SalesChannel { pos, online }

/// An immutable log entry for one inventory quantity change (Issue #439),
/// snapshotting the item name and post-movement quantity so the audit
/// trail survives item edits/removal (same pattern as #441's stock-take
/// records).
@Entity()
class StockMovementEntity {
  @Id()
  int id = 0;

  String itemName;

  int quantity;

  int dbType;

  int resultingQuantityOnHand;

  int dbChannel;

  @Index()
  DateTime occurredAt;

  StockMovementEntity({
    this.id = 0,
    required this.itemName,
    required this.quantity,
    required this.resultingQuantityOnHand,
    required this.occurredAt,
    this.dbType = 0,
    this.dbChannel = 0,
  });

  StockMovementType get type => StockMovementType.values[dbType];
  set type(StockMovementType value) => dbType = value.index;

  SalesChannel get channel => SalesChannel.values[dbChannel];
  set channel(SalesChannel value) => dbChannel = value.index;
}
