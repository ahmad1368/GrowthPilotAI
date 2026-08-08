import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

/// "Strictly Opt-In... automatically terminated the moment the delivery
/// is marked Completed" (Issue #155 AC).
class IsDeliveryTrackingAllowed {
  static bool call(DeliveryEntity delivery) {
    if (!delivery.trackingConsentGiven) return false;
    return delivery.status != DeliveryStatus.completed && delivery.status != DeliveryStatus.canceled;
  }
}
