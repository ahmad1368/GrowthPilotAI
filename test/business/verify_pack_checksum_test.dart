import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/verify_pack_checksum.dart';

void main() {
  const contents = '{"sectorId":"tech","version":1}';
  final expectedChecksum = sha256.convert(utf8.encode(contents)).toString();

  test('accepts contents matching their SHA-256 checksum', () {
    expect(VerifyPackChecksum.call(contents, expectedChecksum), isTrue);
  });

  test('rejects contents that do not match the checksum', () {
    expect(VerifyPackChecksum.call('{"sectorId":"tech","version":2}', expectedChecksum), isFalse);
  });

  test('rejects a garbage checksum string', () {
    expect(VerifyPackChecksum.call(contents, 'not-a-real-checksum'), isFalse);
  });
}
