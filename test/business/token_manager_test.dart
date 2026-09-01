import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/token_manager.dart';
import 'package:growth_pilot_ai/core/models/token_lifecycle.dart';

void main() {
  final issuedAt = DateTime(2027, 1, 1, 12);
  final token = TokenLifecycle.issuedAt(issuedAt);

  group('TokenLifecycle.issuedAt', () {
    test('sets 60-minute access and 100-day refresh expiry', () {
      expect(token.accessExpiresAt, issuedAt.add(const Duration(minutes: 60)));
      expect(token.refreshExpiresAt, issuedAt.add(const Duration(days: 100)));
    });
  });

  group('TokenManager.needsRefresh', () {
    test('is false while the access token is comfortably valid', () {
      expect(TokenManager.needsRefresh(token, issuedAt), isFalse);
    });

    test('is true within the 5-minute skew of expiry', () {
      final near = issuedAt.add(const Duration(minutes: 56));
      expect(TokenManager.needsRefresh(token, near), isTrue);
    });

    test('is true once the access token has expired', () {
      final after = issuedAt.add(const Duration(minutes: 61));
      expect(TokenManager.needsRefresh(token, after), isTrue);
    });
  });

  group('TokenManager.requiresReconnect', () {
    test('is false within the refresh window', () {
      final within = issuedAt.add(const Duration(days: 99));
      expect(TokenManager.requiresReconnect(token, within), isFalse);
    });

    test('is true once the refresh token has expired', () {
      final after = issuedAt.add(const Duration(days: 101));
      expect(TokenManager.requiresReconnect(token, after), isTrue);
    });
  });
}
