import 'package:growth_pilot_ai/core/data/entities/stock_movement_entity.dart';

/// Result of [ComputeStockMovement]: either the resulting quantity on hand,
/// or the reason the movement is rejected (e.g. overselling).
class StockMovementCalculation {
  final int? resultingQuantityOnHand;
  final String? error;

  const StockMovementCalculation._success(this.resultingQuantityOnHand) : error = null;
  const StockMovementCalculation._failure(this.error) : resultingQuantityOnHand = null;

  bool get isValid => error == null;
}

/// Pure sale/return math for one stock movement (Issue #439): the delta and
/// resulting quantity on hand, rejecting a sale that would oversell. No
/// I/O — [ApplyStockMovement] wraps this in the actual ObjectBox write
/// transaction that provides concurrency control.
class ComputeStockMovement {
  static StockMovementCalculation call(
      int currentQuantityOnHand, int quantity, StockMovementType type) {
    final delta = type == StockMovementType.sale ? -quantity : quantity;
    final newQuantity = currentQuantityOnHand + delta;
    if (newQuantity < 0) {
      return const StockMovementCalculation._failure('Not enough stock on hand.');
    }
    return StockMovementCalculation._success(newQuantity);
  }
}
