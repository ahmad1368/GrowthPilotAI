import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/base32_encoder.dart';

void main() {
  group('Base32Encoder', () {
    // RFC 4648 §10 test vectors (Issue #317 feature #3), padding
    // trimmed since this encoder omits it.
    test('encodes known RFC 4648 vectors', () {
      expect(Base32Encoder.encode(ascii.encode('f')), 'MY');
      expect(Base32Encoder.encode(ascii.encode('fo')), 'MZXQ');
      expect(Base32Encoder.encode(ascii.encode('foo')), 'MZXW6');
      expect(Base32Encoder.encode(ascii.encode('foob')), 'MZXW6YQ');
      expect(Base32Encoder.encode(ascii.encode('fooba')), 'MZXW6YTB');
      expect(Base32Encoder.encode(ascii.encode('foobar')), 'MZXW6YTBOI');
    });

    test('encodes an empty byte list to an empty string', () {
      expect(Base32Encoder.encode(const []), '');
    });
  });
}
