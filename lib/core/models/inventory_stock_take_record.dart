import 'package:flutter/foundation.dart';

/// A stock-take audit record with its computed variance (Issue #441).
@immutable
class InventoryStockTakeRecord {
  final String itemName;
  final int systemQuantity;
  final int physicalQuantity;
  final int variance;
  final DateTime takenAt;

  const InventoryStockTakeRecord({
    required this.itemName,
    required this.systemQuantity,
    required this.physicalQuantity,
    required this.variance,
    required this.takenAt,
  });

  bool get hasDiscrepancy => variance != 0;
}
