import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_totp_code.dart';

void main() {
  final secret = ascii.encode('12345678901234567890');
  final stepZero = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

  group('VerifyTotpCode', () {
    test('accepts the correct code for the current step (Issue #317)', () {
      expect(VerifyTotpCode.call(secret, '755224', stepZero), isTrue);
    });

    test('accepts a code from one step of clock drift', () {
      expect(VerifyTotpCode.call(secret, '287082', stepZero), isTrue); // step 1
    });

    test('rejects a code outside the tolerance window', () {
      final stepFive = DateTime.fromMillisecondsSinceEpoch(5 * 30000, isUtc: true);
      expect(VerifyTotpCode.call(secret, '755224', stepFive), isFalse); // step 0's code, 5 steps later
    });

    test('rejects a garbage code', () {
      expect(VerifyTotpCode.call(secret, '000000', stepZero), isFalse);
    });
  });
}
