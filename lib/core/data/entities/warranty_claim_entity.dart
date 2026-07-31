import 'package:objectbox/objectbox.dart';

/// A logged after-sales warranty/service claim (Issue #389) — this app has
/// no warranty-management backend, so claims are recorded manually here,
/// the same lightweight logging pattern [WasteLogEntity] uses.
@Entity()
class WarrantyClaimEntity {
  @Id()
  int id = 0;

  String itemName;

  double claimCost;

  double coverageRevenue;

  @Index()
  @Property(type: PropertyType.date)
  DateTime date;

  WarrantyClaimEntity({
    this.id = 0,
    required this.itemName,
    required this.claimCost,
    required this.coverageRevenue,
    required this.date,
  });
}
