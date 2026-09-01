import 'dart:convert';

/// Enforces the 4KB message payload cap from Issue #122's "Technical
/// Constraints" (prevents DoS on the gateway via oversized frames).
class ValidateChatPayloadSize {
  static const int maxBytes = 4096;

  static bool call(String body) => utf8.encode(body).length <= maxBytes;
}
