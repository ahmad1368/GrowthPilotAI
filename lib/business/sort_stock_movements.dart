import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

/// Most-recent stock movement first (Issue #439).
class SortStockMovements {
  static List<StockMovementEntity> call(List<StockMovementEntity> movements) {
    return [...movements]..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  }
}
