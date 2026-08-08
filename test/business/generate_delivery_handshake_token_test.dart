import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_delivery_handshake_token.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12, 0);

  test('generates a 6-digit token valid for 10 minutes', () {
    final handshake = GenerateDeliveryHandshakeToken.call(1, now, random: Random(42));

    expect(handshake.deliveryId, 1);
    expect(handshake.token.length, 6);
    expect(handshake.used, isFalse);
    expect(handshake.expiresAt, now.add(const Duration(minutes: 10)));
  });

  test('is deterministic given the same seeded random', () {
    final a = GenerateDeliveryHandshakeToken.call(1, now, random: Random(7));
    final b = GenerateDeliveryHandshakeToken.call(1, now, random: Random(7));
    expect(a.token, b.token);
  });
}
