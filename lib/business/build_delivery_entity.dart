import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';

/// Constructs a fresh [DeliveryEntity] (Issue #155), kept out of
/// [DeliveryController] for SRP.
class BuildDeliveryEntity {
  static DeliveryEntity call(int requestId, int paymentId, String courierId,
      {required bool consentGiven, required DateTime now}) {
    return DeliveryEntity(
        requestId: requestId,
        paymentId: paymentId,
        courierId: courierId,
        trackingConsentGiven: consentGiven,
        createdAt: now);
  }
}
