import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/hash_password.dart';

void main() {
  group('HashPassword', () {
    test('is deterministic for the same input', () {
      expect(HashPassword.call('Secret@123'), HashPassword.call('Secret@123'));
    });

    test('produces different hashes for different passwords', () {
      expect(HashPassword.call('Secret@123') == HashPassword.call('Other@123'),
          isFalse);
    });

    test('never returns the plaintext password', () {
      expect(HashPassword.call('Secret@123'), isNot('Secret@123'));
    });
  });
}
