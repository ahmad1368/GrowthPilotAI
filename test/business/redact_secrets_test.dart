import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_secrets.dart';

void main() {
  group('RedactSecrets', () {
    test('redacts a password value (Issue #206 "Secret Scanning")', () {
      final result = RedactSecrets.call('login failed, password: hunter2');
      expect(result, contains('password: [REDACTED]'));
      expect(result, isNot(contains('hunter2')));
    });

    test('redacts a token/apiKey value', () {
      final result = RedactSecrets.call('token=abc123xyz expired');
      expect(result, contains('token: [REDACTED]'));
      expect(result, isNot(contains('abc123xyz')));
    });

    test('leaves ordinary text untouched', () {
      const message = 'ObjectBox store failed to open: disk full';
      expect(RedactSecrets.call(message), message);
    });
  });
}
