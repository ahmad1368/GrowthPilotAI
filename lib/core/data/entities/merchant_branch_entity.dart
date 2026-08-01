import 'package:objectbox/objectbox.dart';

/// Inventory health for a logged branch snapshot (Issue #400).
enum BranchInventoryStatus { healthy, low, critical }

/// A manually-logged supervised-branch performance snapshot (Issue #400)
/// — this app has no multi-tenant backend/enterprise account model, so
/// an enterprise manager records each branch's own reported totals here,
/// the same lightweight logging pattern [NeighborhoodExpansionEntity]
/// uses.
@Entity()
class MerchantBranchEntity {
  @Id()
  int id = 0;

  String branchName;

  double salesTotal;

  int dbInventoryStatus;

  @Index()
  @Property(type: PropertyType.date)
  DateTime reportedAt;

  MerchantBranchEntity({
    this.id = 0,
    required this.branchName,
    required this.salesTotal,
    required this.dbInventoryStatus,
    required this.reportedAt,
  });

  BranchInventoryStatus get inventoryStatus =>
      BranchInventoryStatus.values[dbInventoryStatus];
}
