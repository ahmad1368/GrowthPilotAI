import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:growth_pilot_ai/business/canonicalize_for_hash.dart';
import 'package:growth_pilot_ai/core/models/hash_pepper.dart';

/// Shared deterministic-hashing utility (Issue #89) — strings and complex
/// objects both hash the same way given the same logical content
/// ([CanonicalizeForHash] makes map key order irrelevant). Uses
/// HMAC-SHA256 keyed by [pepper], not raw `input + salt` concatenation
/// (the issue's review flagged that as vulnerable to length-extension and
/// to silently hashing `"undefined"` when the salt is unset).
class GenerateDeterministicHash {
  static String call(Object? data, HashPepper pepper) {
    final canonical = CanonicalizeForHash.call(data);
    final hmac = Hmac(sha256, utf8.encode(pepper.value));
    return hmac.convert(utf8.encode(canonical)).toString();
  }
}
