import 'package:flutter/foundation.dart';

/// Match result between a goods receipt's vendor invoice and the purchase
/// order it was received against (Issue #444). [orderEstimatedTotal] is
/// null if the receipt isn't linked to a known order.
@immutable
class GoodsReceiptMatchRecord {
  final String vendorName;
  final String invoiceReference;
  final double invoiceAmount;
  final double? orderEstimatedTotal;
  final String receivedItemsSummary;
  final String damagedOrMissingNotes;
  final DateTime receivedAt;

  const GoodsReceiptMatchRecord({
    required this.vendorName,
    required this.invoiceReference,
    required this.invoiceAmount,
    required this.orderEstimatedTotal,
    required this.receivedItemsSummary,
    required this.damagedOrMissingNotes,
    required this.receivedAt,
  });

  double? get variance =>
      orderEstimatedTotal == null ? null : invoiceAmount - orderEstimatedTotal!;

  bool get isMatched => variance != null && variance!.abs() <= 0.01;

  bool get hasDamagedOrMissing => damagedOrMissingNotes.trim().isNotEmpty;
}
