import 'package:growth_pilot_ai/business/complete_delivery.dart';
import 'package:growth_pilot_ai/business/generate_delivery_handshake_token.dart';
import 'package:growth_pilot_ai/business/is_handshake_token_valid.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/payment_entity.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_handshake_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/delivery_repository.dart';
import 'package:growth_pilot_ai/core/data/repositories/payment_repository.dart';

/// "Secure QR Handshake... triggers the Payment Release" (Issue #155) —
/// a valid scan flips the buyer's delivery-confirmation flag on the
/// existing #147 [PaymentEntity], reusing its escrow-release logic
/// instead of duplicating it.
class DeliveryHandshakeHandler {
  final DeliveryRepository deliveries;
  final DeliveryHandshakeRepository handshakes;
  final PaymentRepository payments;

  DeliveryHandshakeHandler(this.deliveries, this.handshakes, this.payments);

  String generate(DeliveryEntity delivery, DateTime now) {
    final handshake = GenerateDeliveryHandshakeToken.call(delivery.id, now);
    handshakes.upsert(handshake);
    return handshake.token;
  }

  bool verifyAndComplete(
      DeliveryEntity delivery, PaymentEntity payment, String scannedToken, DateTime now) {
    final handshake = handshakes.getForDelivery(delivery.id);
    if (handshake == null || !IsHandshakeTokenValid.call(handshake, scannedToken, now)) return false;

    handshake.used = true;
    handshakes.upsert(handshake);
    deliveries.upsert(CompleteDelivery.call(delivery, now));
    payment.buyerConfirmedDelivery = true;
    payments.insert(payment);
    return true;
  }
}
