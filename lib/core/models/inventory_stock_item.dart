import 'package:flutter/foundation.dart';
import 'package:growth_pilot_ai/business/compute_inventory_expiry_status.dart';

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
  final InventoryExpiryStatus expiryStatus;

  /// Pre-formatted "Expires in Xd"/"Xd expired" text, computed against the
  /// same `now` used for [expiryStatus] — null unless expiring/expired, so
  /// the UI never has to call `DateTime.now()` itself (Issue #438).
  final String? expiryLabel;

  final String serialNumber;
  final Map<String, String> attributes;

  const InventoryStockItem({
    required this.name,
    required this.quantityOnHand,
    required this.reorderThreshold,
    required this.unitCost,
    required this.status,
    this.categoryPath,
    this.sku = '',
    this.expiryStatus = InventoryExpiryStatus.none,
    this.expiryLabel,
    this.serialNumber = '',
    this.attributes = const {},
  });
}
