import 'package:crypto/crypto.dart';

/// Verifies a downloaded backup blob is intact before it is restored, by
/// comparing its SHA-256 against the expected checksum. Pure Dart, web-safe.
class BackupIntegrity {
  static String sha256Of(List<int> bytes) => sha256.convert(bytes).toString();

  /// True when [bytes] hash to [expectedSha256Hex] (the backup was not
  /// corrupted in transit). Comparison is case-insensitive on the hex.
  static bool verify(List<int> bytes, String expectedSha256Hex) =>
      sha256Of(bytes) == expectedSha256Hex.toLowerCase();
}
