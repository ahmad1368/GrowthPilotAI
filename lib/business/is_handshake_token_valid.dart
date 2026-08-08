import 'package:growth_pilot_ai/core/data/entities/delivery_handshake_entity.dart';

/// Pairs with [GenerateDeliveryHandshakeToken] — a scan only finalizes
/// the delivery if the token matches, hasn't been used, and hasn't
/// expired.
class IsHandshakeTokenValid {
  static bool call(DeliveryHandshakeEntity handshake, String scannedToken, DateTime now) {
    if (handshake.used) return false;
    if (now.isAfter(handshake.expiresAt)) return false;
    return handshake.token == scannedToken;
  }
}
