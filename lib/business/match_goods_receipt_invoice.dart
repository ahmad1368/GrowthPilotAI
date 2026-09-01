import 'package:growth_pilot_ai/core/data/entities/goods_receipt_entity.dart';
import 'package:growth_pilot_ai/core/models/goods_receipt_match_record.dart';

/// Matches each goods-receipt's vendor invoice against the purchase order
/// it was received against (Issue #444), flagging amount discrepancies so
/// staff can catch over/under-billing before paying an invoice. Most
/// recent receipt first.
class MatchGoodsReceiptInvoice {
  static List<GoodsReceiptMatchRecord> call(List<GoodsReceiptEntity> receipts) {
    final results = receipts.map((r) {
      final order = r.purchaseOrder.target;
      return GoodsReceiptMatchRecord(
        vendorName: order?.vendorName ?? '',
        invoiceReference: r.invoiceReference,
        invoiceAmount: r.invoiceAmount,
        orderEstimatedTotal: order?.estimatedTotal,
        receivedItemsSummary: r.receivedItemsSummary,
        damagedOrMissingNotes: r.damagedOrMissingNotes,
        receivedAt: r.receivedAt,
      );
    }).toList()
      ..sort((a, b) => b.receivedAt.compareTo(a.receivedAt));

    return results;
  }
}
