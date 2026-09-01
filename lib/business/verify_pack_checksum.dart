import 'dart:convert';
import 'package:crypto/crypto.dart';

/// "Integrity: SHA-256 Checksum verification" (Issue #86 scope item 2) —
/// confirms a pack's contents match the checksum its metadata claims
/// before the pack is trusted, catching corruption in transit.
class VerifyPackChecksum {
  static bool call(String packContents, String expectedChecksumHex) =>
      sha256.convert(utf8.encode(packContents)).toString() == expectedChecksumHex;
}
