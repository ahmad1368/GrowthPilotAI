import 'dart:convert';
import 'package:crypto/crypto.dart';

/// Deterministic, trackable referral code linked to the inviter and
/// contact (Issue #542, acceptance criterion 2) — derived from a
/// SHA-256 hash instead of randomness so the same invite always
/// produces the same code, making it easy to verify/re-derive without
/// storing a separate lookup table.
class GenerateReferralCode {
  static String call(String inviterName, String contactIdentifier, DateTime issuedAt) {
    final canonical = '$inviterName|$contactIdentifier|${issuedAt.toIso8601String()}';
    final digest = sha256.convert(utf8.encode(canonical)).toString();
    return digest.substring(0, 8).toUpperCase();
  }
}
