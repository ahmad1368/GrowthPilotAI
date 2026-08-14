import 'package:objectbox/objectbox.dart';

/// One B2B checkout of one or more wholesale listings (Issue #411,
/// acceptance criterion 3) — [itemsSummary] flattens the purchased
/// line items into one string instead of a normalized line-item
/// table, mirroring [PurchaseOrderEntity]'s (#443) simplification.
@Entity()
class WholesaleOrderEntity {
  @Id()
  int id = 0;

  String buyerMerchantName;
  String itemsSummary;
  double totalAmount;

  @Property(type: PropertyType.date)
  DateTime orderedAt;

  WholesaleOrderEntity({
    this.id = 0,
    required this.buyerMerchantName,
    required this.itemsSummary,
    required this.totalAmount,
    required this.orderedAt,
  });
}
