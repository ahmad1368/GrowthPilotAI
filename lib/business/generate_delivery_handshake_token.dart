import 'dart:math';
import 'package:growth_pilot_ai/core/data/entities/delivery_handshake_entity.dart';

/// "Secure, time-sensitive QR code" (Issue #155) — a 6-digit numeric
/// token (easy to also show as a fallback manual-entry code in a
/// low-connectivity loading dock) valid for 10 minutes.
class GenerateDeliveryHandshakeToken {
  static const validity = Duration(minutes: 10);

  static DeliveryHandshakeEntity call(int deliveryId, DateTime now, {Random? random}) {
    final token = (random ?? Random.secure()).nextInt(900000) + 100000;
    return DeliveryHandshakeEntity(
      deliveryId: deliveryId,
      token: token.toString(),
      expiresAt: now.add(validity),
      createdAt: now,
    );
  }
}
