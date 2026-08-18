import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/strip_control_characters.dart';

void main() {
  group('StripControlCharacters', () {
    test('removes form-feed, vertical-tab, and backspace codes', () {
      expect(StripControlCharacters.call('a\x0Cb\x0Bc\x08d'), 'abcd');
    });

    test('preserves newlines and tabs', () {
      expect(StripControlCharacters.call('a\nb\tc'), 'a\nb\tc');
    });
  });
}
