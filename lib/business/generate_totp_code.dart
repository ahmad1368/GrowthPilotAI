import 'dart:typed_data';
import 'package:crypto/crypto.dart';

/// TOTP code generation (RFC 6238 / RFC 4226) — Issue #317 feature #3
/// (2FA via Authenticator Apps). Uses HMAC-SHA1/30s-step/6-digit, the
/// default every mainstream authenticator app (Google Authenticator,
/// Authy) assumes.
class GenerateTotpCode {
  static const period = 30;
  static const digits = 6;

  static String call(List<int> secretBytes, DateTime now) {
    final counter = now.millisecondsSinceEpoch ~/ 1000 ~/ period;
    final counterBytes = ByteData(8)..setInt64(0, counter, Endian.big);
    final hmac = Hmac(sha1, secretBytes).convert(counterBytes.buffer.asUint8List()).bytes;

    final offset = hmac[19] & 0xf;
    final binCode = (hmac[offset] & 0x7f) << 24 |
        (hmac[offset + 1] & 0xff) << 16 |
        (hmac[offset + 2] & 0xff) << 8 |
        (hmac[offset + 3] & 0xff);

    return (binCode % 1000000).toString().padLeft(digits, '0');
  }
}
