import 'package:growth_pilot_ai/core/data/entities/delivery_location_history_entity.dart';

/// "Path History purged after 30 days" (Issue #155 AC) — the local
/// stand-in for a scheduled cleanup job; returns only the entries that
/// should be deleted, mirroring #126's `ExpireOverdueProcurementRequests`.
class PurgeStaleDeliveryLocationHistory {
  static const retention = Duration(days: 30);

  static List<DeliveryLocationHistoryEntity> call(
      List<DeliveryLocationHistoryEntity> history, DateTime now) {
    return history.where((entry) => now.difference(entry.recordedAt) > retention).toList();
  }
}
