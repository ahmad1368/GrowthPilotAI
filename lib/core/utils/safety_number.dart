import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Signal-style Safety Number (fingerprint) verification for E2EE chat. Two
/// participants who compare the same 60-digit number are talking directly —
/// any key substitution (MITM) changes it. Pure Dart, web-safe.
class SafetyNumber {
  static const int _iterations = 1024;

  /// A stable 30-digit fingerprint for a single public key.
  static String fingerprint(String publicKeyBase64) {
    var digest = sha256.convert(utf8.encode(publicKeyBase64)).bytes;
    for (var i = 0; i < _iterations; i++) {
      digest = sha256.convert(digest).bytes;
    }
    final buffer = StringBuffer();
    for (var i = 0; i < 6; i++) {
      final chunk = ((digest[i * 2] << 8) | digest[i * 2 + 1]) % 100000;
      buffer.write(chunk.toString().padLeft(5, '0'));
    }
    return buffer.toString();
  }

  /// Order-independent 60-digit safety number for two participants: both sides
  /// compute the same value regardless of who is "local".
  static String forPair(String localKeyBase64, String remoteKeyBase64) {
    final local = fingerprint(localKeyBase64);
    final remote = fingerprint(remoteKeyBase64);
    final ordered = localKeyBase64.compareTo(remoteKeyBase64) <= 0
        ? '$local$remote'
        : '$remote$local';
    final groups = <String>[];
    for (var i = 0; i < ordered.length; i += 5) {
      groups.add(ordered.substring(i, i + 5));
    }
    return groups.join(' ');
  }
}
