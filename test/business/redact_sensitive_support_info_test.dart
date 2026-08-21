import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_sensitive_support_info.dart';

void main() {
  group('RedactSensitiveSupportInfo', () {
    test('redacts a password value (Issue #193 AC: PII never sent)', () {
      final result = RedactSensitiveSupportInfo.call('my password: hunter2 is not working');
      expect(result, contains('password: [REDACTED]'));
      expect(result, isNot(contains('hunter2')));
    });

    test('redacts a token/apiKey value', () {
      final result = RedactSensitiveSupportInfo.call('token=abc123xyz failed to refresh');
      expect(result, contains('token: [REDACTED]'));
      expect(result, isNot(contains('abc123xyz')));
    });

    test('leaves ordinary messages untouched', () {
      const message = 'My bank connection keeps failing after MFA.';
      expect(RedactSensitiveSupportInfo.call(message), message);
    });
  });
}
