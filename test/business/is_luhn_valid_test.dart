import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_luhn_valid.dart';

void main() {
  test('accepts a known-valid test card number', () {
    expect(IsLuhnValid.call('4532015112830366'), isTrue);
  });

  test('rejects a sequential number that fails the checksum', () {
    expect(IsLuhnValid.call('1234567890123456'), isFalse);
  });

  test('rejects an empty string', () {
    expect(IsLuhnValid.call(''), isFalse);
  });
}
