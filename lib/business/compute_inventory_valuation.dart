import 'package:growth_pilot_ai/core/data/entities/inventory_cost_layer_entity.dart';
import 'package:growth_pilot_ai/core/models/valuation_method.dart';

/// Values the quantity still on hand against its cost layers (Issue #446).
/// FIFO assumes the oldest units sold first, so what remains is the most
/// recent layers; LIFO assumes the newest sold first, so what remains is
/// the oldest layers; weighted average blends cost across every layer
/// regardless of order. Pure — no I/O.
class ComputeInventoryValuation {
  static double call(
      int quantityOnHand, List<InventoryCostLayerEntity> layers, ValuationMethod method) {
    if (quantityOnHand <= 0 || layers.isEmpty) return 0;
    if (method == ValuationMethod.weightedAverage) return _weightedAverage(quantityOnHand, layers);

    final oldestFirst = [...layers]..sort((a, b) => a.receivedAt.compareTo(b.receivedAt));
    final remainingLayers = method == ValuationMethod.fifo
        ? oldestFirst.reversed.toList()
        : oldestFirst;
    return _consume(quantityOnHand, remainingLayers);
  }

  static double _weightedAverage(int quantityOnHand, List<InventoryCostLayerEntity> layers) {
    final totalQty = layers.fold<int>(0, (sum, l) => sum + l.quantity);
    if (totalQty == 0) return 0;
    final totalCost = layers.fold<double>(0, (sum, l) => sum + l.quantity * l.unitCost);
    return quantityOnHand * (totalCost / totalQty);
  }

  static double _consume(int quantityOnHand, List<InventoryCostLayerEntity> orderedLayers) {
    var remaining = quantityOnHand;
    var value = 0.0;
    for (final layer in orderedLayers) {
      if (remaining <= 0) break;
      final take = remaining < layer.quantity ? remaining : layer.quantity;
      value += take * layer.unitCost;
      remaining -= take;
    }
    return value;
  }
}
