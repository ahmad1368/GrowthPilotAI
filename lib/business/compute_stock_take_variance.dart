import 'package:growth_pilot_ai/core/data/entities/inventory_stock_take_entity.dart';
import 'package:growth_pilot_ai/core/models/inventory_stock_take_record.dart';

/// Computes the variance (physical minus system count) for each stock-take
/// audit record, most-recent first (Issue #441).
class ComputeStockTakeVariance {
  static List<InventoryStockTakeRecord> call(List<InventoryStockTakeEntity> records) {
    final results = records
        .map((r) => InventoryStockTakeRecord(
              itemName: r.itemName,
              systemQuantity: r.systemQuantity,
              physicalQuantity: r.physicalQuantity,
              variance: r.physicalQuantity - r.systemQuantity,
              takenAt: r.takenAt,
            ))
        .toList()
      ..sort((a, b) => b.takenAt.compareTo(a.takenAt));

    return results;
  }
}
