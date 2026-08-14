import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/enum/delivery_status.dart';

/// Finalizes a delivery once its QR handshake is verified (Issue #155)
/// — this alone is what stops tracking, per [IsDeliveryTrackingAllowed].
class CompleteDelivery {
  static DeliveryEntity call(DeliveryEntity delivery, DateTime now) {
    delivery.status = DeliveryStatus.completed;
    delivery.completedAt = now;
    return delivery;
  }
}
