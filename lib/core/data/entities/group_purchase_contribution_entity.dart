import 'package:objectbox/objectbox.dart';

/// One merchant's partial order quantity pledged toward a
/// [GroupPurchaseEntity]'s collective volume threshold (Issue #414,
/// acceptance criterion 1).
@Entity()
class GroupPurchaseContributionEntity {
  @Id()
  int id = 0;

  @Index()
  int groupPurchaseId;

  String merchantName;
  int quantity;

  @Property(type: PropertyType.date)
  DateTime contributedAt;

  GroupPurchaseContributionEntity({
    this.id = 0,
    required this.groupPurchaseId,
    required this.merchantName,
    required this.quantity,
    required this.contributedAt,
  });
}
