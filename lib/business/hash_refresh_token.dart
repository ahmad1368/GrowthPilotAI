import 'dart:convert';
import 'package:crypto/crypto.dart';

/// SHA-256 hash of a refresh token before it's persisted (Issue #120,
/// acceptance criterion: "Refresh Tokens must be hashed in the
/// database, never stored in plain text").
class HashRefreshToken {
  static String call(String rawToken) => sha256.convert(utf8.encode(rawToken)).toString();
}
