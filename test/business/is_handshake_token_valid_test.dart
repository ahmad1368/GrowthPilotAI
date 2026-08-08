import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_handshake_token_valid.dart';
import 'package:growth_pilot_ai/core/data/entities/delivery_handshake_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12, 0);

  DeliveryHandshakeEntity handshake({bool used = false, DateTime? expiresAt}) =>
      DeliveryHandshakeEntity(
          deliveryId: 1,
          token: '123456',
          used: used,
          expiresAt: expiresAt ?? now.add(const Duration(minutes: 10)),
          createdAt: now);

  test('valid when the token matches and it is unused and unexpired', () {
    expect(IsHandshakeTokenValid.call(handshake(), '123456', now), isTrue);
  });

  test('invalid when the scanned token does not match', () {
    expect(IsHandshakeTokenValid.call(handshake(), '000000', now), isFalse);
  });

  test('invalid once already used', () {
    expect(IsHandshakeTokenValid.call(handshake(used: true), '123456', now), isFalse);
  });

  test('invalid once expired', () {
    final expired = handshake(expiresAt: now.subtract(const Duration(minutes: 1)));
    expect(IsHandshakeTokenValid.call(expired, '123456', now), isFalse);
  });
}
