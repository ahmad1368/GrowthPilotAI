import 'dart:convert';
import 'package:crypto/crypto.dart';

/// One-way, salted SHA-256 pseudonymization. The same input + salt always
/// yields the same hash, so analytics can group by "Company A" without ever
/// knowing who that is. The salt comes from --dart-define (never hardcoded).
class Pseudonymizer {
  static const String _salt = String.fromEnvironment('ANON_SALT');

  static String hash(String value, {String? salt}) {
    final bytes = utf8.encode('${salt ?? _salt}:$value');
    return sha256.convert(bytes).toString();
  }
}
