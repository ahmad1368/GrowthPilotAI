import 'package:growth_pilot_ai/business/build_delivery_location_history_entry.dart';
import 'package:growth_pilot_ai/business/estimate_eta_minutes.dart';
import 'package:growth_pilot_ai/business/is_delivery_tracking_allowed.dart';
import 'package:growth_pilot_ai/business/purge_stale_delivery_location_history.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_location_history_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_repository.dart';

/// "Live Map Overlay" / "ETA updates" backend (Issue #155) — no
/// Google Maps SDK/WebSocket broadcast is wired up here (that's a UI +
/// #130 realtime-gateway follow-up); this only maintains the
/// authoritative last-known position and route history.
class DeliveryLocationHandler {
  final DeliveryRepository deliveries;
  final DeliveryLocationHistoryRepository history;

  DeliveryLocationHandler(this.deliveries, this.history);

  double? recordLocation(DeliveryEntity delivery, double lat, double lng, DateTime now,
      {required double destLat, required double destLng}) {
    if (!IsDeliveryTrackingAllowed.call(delivery)) return null;

    delivery.courierLat = lat;
    delivery.courierLng = lng;
    delivery.lastLocationAt = now;
    deliveries.upsert(delivery);
    history.insert(BuildDeliveryLocationHistoryEntry.call(delivery.id, lat, lng, now));

    final stale = PurgeStaleDeliveryLocationHistory.call(history.getForDelivery(delivery.id), now);
    if (stale.isNotEmpty) history.removeAll(stale);

    return EstimateEtaMinutes.call(lat, lng, destLat, destLng);
  }
}
