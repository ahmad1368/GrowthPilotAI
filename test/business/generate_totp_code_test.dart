import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_totp_code.dart';

void main() {
  // RFC 4226 Appendix D test vectors (HOTP with secret
  // "12345678901234567890"); TOTP(T) == HOTP(K, T) where T is the step
  // counter, so picking `now` to land on step N reuses those vectors
  // (Issue #317 feature #3).
  final secret = ascii.encode('12345678901234567890');

  group('GenerateTotpCode', () {
    test('matches the RFC 4226 vector for step 0', () {
      final now = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
      expect(GenerateTotpCode.call(secret, now), '755224');
    });

    test('matches the RFC 4226 vector for step 1', () {
      final now = DateTime.fromMillisecondsSinceEpoch(30000, isUtc: true);
      expect(GenerateTotpCode.call(secret, now), '287082');
    });

    test('matches the RFC 4226 vector for step 9', () {
      final now = DateTime.fromMillisecondsSinceEpoch(9 * 30000, isUtc: true);
      expect(GenerateTotpCode.call(secret, now), '520489');
    });

    test('produces a stable code within the same 30s step', () {
      final a = GenerateTotpCode.call(secret, DateTime.fromMillisecondsSinceEpoch(0, isUtc: true));
      final b = GenerateTotpCode.call(secret, DateTime.fromMillisecondsSinceEpoch(29000, isUtc: true));
      expect(a, b);
    });
  });
}
