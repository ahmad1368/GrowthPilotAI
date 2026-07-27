import 'package:objectbox/objectbox.dart';
import 'purchase_order_entity.dart';

/// A recorded shipment received against a purchase order (Issue #444):
/// what physically arrived, any damaged/missing items noted during
/// intake, and the vendor invoice details for reconciliation.
@Entity()
class GoodsReceiptEntity {
  @Id()
  int id = 0;

  final purchaseOrder = ToOne<PurchaseOrderEntity>();

  String receivedItemsSummary;

  String damagedOrMissingNotes;

  String invoiceReference;

  double invoiceAmount;

  @Index()
  DateTime receivedAt;

  GoodsReceiptEntity({
    this.id = 0,
    required this.receivedItemsSummary,
    this.damagedOrMissingNotes = '',
    this.invoiceReference = '',
    required this.invoiceAmount,
    required this.receivedAt,
  });
}
