import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/chat_ciphertext_format_validator.dart';

void main() {
  group('ChatCiphertextFormatValidator', () {
    test('accepts a well-formed iv:ciphertext pair', () {
      expect(ChatCiphertextFormatValidator.isValid('aGVsbG8=:d29ybGQ='), isTrue);
    });

    test('rejects legacy plaintext with no colon separator', () {
      expect(ChatCiphertextFormatValidator.isValid('hello world'), isFalse);
    });

    test('rejects malformed base64 segments', () {
      expect(ChatCiphertextFormatValidator.isValid('not-base64!!:also-bad!!'), isFalse);
    });

    test('rejects empty segments and extra colons', () {
      expect(ChatCiphertextFormatValidator.isValid(':d29ybGQ='), isFalse);
      expect(ChatCiphertextFormatValidator.isValid('aGVsbG8=:d29ybGQ=:extra'), isFalse);
    });

    test('rejects null', () {
      expect(ChatCiphertextFormatValidator.isValid(null), isFalse);
    });
  });
}
