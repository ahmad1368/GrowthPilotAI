import 'package:flutter/foundation.dart';

/// Stock-level tier for one inventory item based on its reorder threshold
/// (Issue #435).
enum InventoryStockStatus { ok, lowStock }

/// One inventory item's computed stock status (Issue #435).
@immutable
class InventoryStockItem {
  final String name;
  final int quantityOnHand;
  final int reorderThreshold;
  final double unitCost;
  final InventoryStockStatus status;
  final String? categoryPath;
  final String sku;

  const InventoryStockItem({
    required this.name,
    required this.quantityOnHand,
    required this.reorderThreshold,
    required this.unitCost,
    required this.status,
    this.categoryPath,
    this.sku = '',
  });
}
