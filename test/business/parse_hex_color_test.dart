import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/parse_hex_color.dart';

void main() {
  group('ParseHexColor', () {
    test('parses a known preset hex (Issue #317 feature #25)', () {
      expect(ParseHexColor.call('#2563EB'), const Color(0xFF2563EB));
    });

    test('parses black and white correctly', () {
      expect(ParseHexColor.call('#000000'), const Color(0xFF000000));
      expect(ParseHexColor.call('#FFFFFF'), const Color(0xFFFFFFFF));
    });

    test('is case-insensitive for hex digits', () {
      expect(ParseHexColor.call('#dc2626'), const Color(0xFFDC2626));
    });
  });
}
