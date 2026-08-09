import 'package:flutter/foundation.dart';

/// One tracked asset's service history, as read from wherever assets are
/// stored (Issue #157: "Maintenance Logic"). Kept separate from any
/// ObjectBox entity so [ScanAssetMaintenanceAlerts] stays storage-agnostic.
@immutable
class AssetMaintenanceInput {
  final String itemName;
  final DateTime? lastServiceDate;
  final int serviceIntervalDays;

  const AssetMaintenanceInput({
    required this.itemName,
    this.lastServiceDate,
    this.serviceIntervalDays = 180,
  });
}
