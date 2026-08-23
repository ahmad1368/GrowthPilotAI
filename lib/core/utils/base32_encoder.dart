/// RFC 4648 Base32 encoding (Issue #317 feature #3, "2FA via
/// Authenticator Apps") — renders a TOTP secret in the format every
/// authenticator app's `otpauth://` provisioning URI expects.
class Base32Encoder {
  static const _alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

  static String encode(List<int> bytes) {
    final buffer = StringBuffer();
    var bits = 0, value = 0;
    for (final byte in bytes) {
      value = (value << 8) | byte;
      bits += 8;
      while (bits >= 5) {
        buffer.write(_alphabet[(value >> (bits - 5)) & 0x1f]);
        bits -= 5;
      }
    }
    if (bits > 0) {
      buffer.write(_alphabet[(value << (5 - bits)) & 0x1f]);
    }
    return buffer.toString();
  }
}
