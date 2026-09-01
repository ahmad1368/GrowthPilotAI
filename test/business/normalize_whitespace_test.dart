import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/normalize_whitespace.dart';

void main() {
  group('NormalizeWhitespace', () {
    test('collapses repeated spaces and tabs into one space', () {
      expect(NormalizeWhitespace.call('a   b\t\tc'), 'a b c');
    });

    test('caps runs of newlines at two, preserving paragraph breaks', () {
      expect(NormalizeWhitespace.call('a\n\n\n\n\nb'), 'a\n\nb');
    });

    test('trims leading and trailing whitespace', () {
      expect(NormalizeWhitespace.call('  a  '), 'a');
    });
  });
}
