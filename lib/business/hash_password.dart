import 'dart:convert';
import 'package:crypto/crypto.dart';

/// [Issue #788] One-way SHA-256 hash for locally-registered account
/// passwords, so [RegisteredUserStore] never persists plaintext —
/// mirrors the existing `sha256.convert(utf8.encode(x)).toString()`
/// pattern used by `hash_refresh_token.dart` elsewhere in this codebase.
class HashPassword {
  static String call(String password) =>
      sha256.convert(utf8.encode(password)).toString();
}
