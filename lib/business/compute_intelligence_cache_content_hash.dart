import 'dart:convert';

import 'package:crypto/crypto.dart';

/// SHA-256 of the plaintext distilled snapshot (Issue #106, companion to
/// #105's Delta-Update Logic) — lets [HasIntelligenceCacheEntryChanged]
/// detect an unchanged sync without ever decrypting the stored
/// ciphertext.
class ComputeIntelligenceCacheContentHash {
  static String call(String snapshotJson) =>
      sha256.convert(utf8.encode(snapshotJson)).toString();
}
