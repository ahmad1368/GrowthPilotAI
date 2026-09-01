import 'package:flutter/foundation.dart';

/// A suggested purchase-order draft (Issue #443), computed from low-stock
/// inventory items before the user reviews/edits it.
@immutable
class PurchaseOrderDraft {
  final String itemsSummary;
  final double estimatedTotal;

  const PurchaseOrderDraft({required this.itemsSummary, required this.estimatedTotal});
}
