import 'dart:convert';

import 'package:crypto/crypto.dart';

/// SHA-256 tamper-detection checksum over one cache row's stored fields
/// (Issue #106 AC: "Auto-Wipe Policy... if OS tampering is detected"),
/// mirroring #428's `ComputeCraLogChecksum` verify-by-rehash pattern —
/// computed over the ciphertext exactly as stored, so verification
/// never needs the decryption key.
class ComputeIntelligenceCacheChecksum {
  static String call({
    required String itemId,
    required String sectorId,
    required String encryptedSnapshot,
    required DateTime syncedAt,
  }) {
    final canonical =
        [itemId, sectorId, encryptedSnapshot, syncedAt.toIso8601String()].join('|');
    return sha256.convert(utf8.encode(canonical)).toString();
  }
}
