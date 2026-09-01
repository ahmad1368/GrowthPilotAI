import 'dart:convert';
import 'package:crypto/crypto.dart';

/// "The Idempotency Rule: if a user uploads the same file twice, the
/// system recognizes it (via MD5/SHA-256 hash)" (Issue #232).
class ComputeDocumentContentHash {
  static String call(String content) => sha256.convert(utf8.encode(content)).toString();
}
