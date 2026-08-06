import 'package:growth_pilot_ai/core/data/entities/pre_order_reservation_entity.dart';
import 'package:growth_pilot_ai/core/enum/pre_order_reservation_status.dart';

/// Compiles regional pre-order totals for a catalog line so the
/// primary supplier can plan production/distribution (Issue #417,
/// acceptance criterion 4) — refunded reservations are excluded since
/// they no longer represent real demand.
class AggregatePreOrderDemand {
  static ({int totalQuantity, int reservationCount}) call(
      int catalogItemId, List<PreOrderReservationEntity> reservations) {
    final active = reservations.where((r) =>
        r.catalogItemId == catalogItemId && r.status != PreOrderReservationStatus.refunded);
    final totalQuantity = active.fold<int>(0, (sum, r) => sum + r.quantity);
    return (totalQuantity: totalQuantity, reservationCount: active.length);
  }
}
