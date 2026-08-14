import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_chat_payload_size.dart';

void main() {
  test('accepts a message within the 4KB cap', () {
    expect(ValidateChatPayloadSize.call('hello'), isTrue);
  });

  test('accepts a message exactly at the 4KB cap', () {
    final body = 'a' * ValidateChatPayloadSize.maxBytes;
    expect(ValidateChatPayloadSize.call(body), isTrue);
  });

  test('rejects a message over the 4KB cap', () {
    final body = 'a' * (ValidateChatPayloadSize.maxBytes + 1);
    expect(ValidateChatPayloadSize.call(body), isFalse);
  });

  test('counts multi-byte UTF-8 characters correctly', () {
    // Each '🚀' is 4 UTF-8 bytes, so 1025 of them exceed the 4096 byte cap
    // even though the Dart string length is only 1025 code points.
    final body = '🚀' * 1025;
    expect(ValidateChatPayloadSize.call(body), isFalse);
  });
}
