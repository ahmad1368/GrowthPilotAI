import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Builds a real, HMAC-signed JWT-shaped access token (Issue #120,
/// "Access Token (JWT)") — signed with a local-only secret since this
/// app has no server holding that secret separately from the client
/// verifying it, so unlike a real backend-issued JWT this provides no
/// actual security boundary; it faithfully replicates the token's
/// structure and short-lived lifecycle, not a trust boundary.
class GenerateAccessToken {
  static const _localSecret = 'growthpilot-local-simulated-secret';

  static String call(String subject, DateTime expiresAt) {
    final header = _b64({'alg': 'HS256', 'typ': 'JWT'});
    final payload = _b64({'sub': subject, 'exp': expiresAt.millisecondsSinceEpoch ~/ 1000});
    return '$header.$payload.${_sign('$header.$payload')}';
  }

  static String _b64(Map<String, dynamic> data) =>
      base64Url.encode(utf8.encode(jsonEncode(data))).replaceAll('=', '');

  static String _sign(String data) =>
      base64Url.encode(Hmac(sha256, utf8.encode(_localSecret)).convert(utf8.encode(data)).bytes)
          .replaceAll('=', '');
}
