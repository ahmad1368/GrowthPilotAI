import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/authorize_chat_connection.dart';
import 'package:growth_pilot_ai/core/data/entities/auth_session_entity.dart';

void main() {
  final now = DateTime(2026, 1, 1, 12);

  AuthSessionEntity session({bool revoked = false, required DateTime expiresAt}) =>
      AuthSessionEntity(
        deviceLabel: 'device',
        accessToken: 'token',
        accessTokenExpiresAt: expiresAt,
        refreshTokenHash: 'hash',
        refreshTokenExpiresAt: expiresAt,
        isRevoked: revoked,
        createdAt: now,
      );

  test('authorizes with an active, unexpired session', () {
    final active = session(expiresAt: now.add(const Duration(hours: 1)));
    expect(AuthorizeChatConnection.call([active], now), isTrue);
  });

  test('rejects when every session is expired', () {
    final expired = session(expiresAt: now.subtract(const Duration(minutes: 1)));
    expect(AuthorizeChatConnection.call([expired], now), isFalse);
  });

  test('rejects when the only unexpired session is revoked', () {
    final revoked =
        session(revoked: true, expiresAt: now.add(const Duration(hours: 1)));
    expect(AuthorizeChatConnection.call([revoked], now), isFalse);
  });

  test('rejects with no sessions at all', () {
    expect(AuthorizeChatConnection.call([], now), isFalse);
  });
}
