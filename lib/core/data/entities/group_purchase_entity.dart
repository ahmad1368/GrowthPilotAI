import 'package:objectbox/objectbox.dart';
import 'package:growth_pilot_ai/core/enum/group_purchase_status.dart';

/// A group-buying campaign aggregating demand from multiple merchants
/// to unlock a wholesale volume discount (Issue #414) — this app has
/// no live supplier API, so "supplier integration" (acceptance
/// criterion 5) is simulated via an audit log entry on finalization.
@Entity()
class GroupPurchaseEntity {
  @Id()
  int id = 0;

  String organizerName;
  String itemName;
  String itemDescription;
  double unitPrice;
  int minQuantityThreshold;
  int dbStatus; // GroupPurchaseStatus index

  @Property(type: PropertyType.date)
  DateTime deadline;

  @Property(type: PropertyType.date)
  DateTime createdAt;

  GroupPurchaseEntity({
    this.id = 0,
    required this.organizerName,
    required this.itemName,
    required this.itemDescription,
    required this.unitPrice,
    required this.minQuantityThreshold,
    this.dbStatus = 0, // GroupPurchaseStatus.open
    required this.deadline,
    required this.createdAt,
  });

  GroupPurchaseStatus get status => GroupPurchaseStatus.values[dbStatus];
  set status(GroupPurchaseStatus value) => dbStatus = value.index;
}
