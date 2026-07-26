import 'package:objectbox/objectbox.dart';

/// Status for a purchase order (Issue #443). "Sent" only marks the order
/// dispatched locally — no email/messaging integration exists to actually
/// deliver it (same gap as #440's notification dispatch).
enum PurchaseOrderStatus { draft, sent }

/// A draft or sent purchase order (Issue #443), auto-suggested from
/// low-stock inventory items but reviewed/edited by the user before saving.
@Entity()
class PurchaseOrderEntity {
  @Id()
  int id = 0;

  String vendorName;

  String itemsSummary;

  double estimatedTotal;

  @Index()
  DateTime createdAt;

  int dbStatus;

  PurchaseOrderEntity({
    this.id = 0,
    required this.vendorName,
    required this.itemsSummary,
    required this.estimatedTotal,
    required this.createdAt,
    this.dbStatus = 0,
  });

  PurchaseOrderStatus get status => PurchaseOrderStatus.values[dbStatus];
  set status(PurchaseOrderStatus value) => dbStatus = value.index;
}
