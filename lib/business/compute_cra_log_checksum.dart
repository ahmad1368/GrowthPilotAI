import 'dart:convert';
import 'package:crypto/crypto.dart';

/// SHA-256 checksum over one CRA log entry's stored fields (Issue
/// #428, acceptance criterion 5), mirroring [BackupIntegrity]'s
/// verify-by-rehash pattern — computed over the field values exactly
/// as stored (including ciphertext), so verification never needs the
/// decryption key.
class ComputeCraLogChecksum {
  static String call({
    required String counterpartyNameEncrypted,
    required double amount,
    required String currency,
    required double exchangeRateAtSettlement,
    required String transactionHash,
    required DateTime loggedAt,
  }) {
    final canonical = [
      counterpartyNameEncrypted,
      amount,
      currency,
      exchangeRateAtSettlement,
      transactionHash,
      loggedAt.toIso8601String(),
    ].join('|');
    return sha256.convert(utf8.encode(canonical)).toString();
  }
}
