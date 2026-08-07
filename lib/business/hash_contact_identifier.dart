import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:growth_pilot_ai/business/normalize_contact_identifier.dart';

/// Client-side SHA-256 hashing of a contact identifier (Issue #541,
/// acceptance criterion 2) — the raw phone number/email is never
/// transmitted or stored; only this hash ever leaves the device.
class HashContactIdentifier {
  static String call(String rawIdentifier) {
    final normalized = NormalizeContactIdentifier.call(rawIdentifier);
    return sha256.convert(utf8.encode(normalized)).toString();
  }
}
