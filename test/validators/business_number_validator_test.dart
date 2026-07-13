import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/business_number_validator.dart';

void main() {
  group('BusinessNumberValidator', () {
    test('accepts exactly 9 digits', () {
      expect(BusinessNumberValidator.isValid('123456789'), isTrue);
    });

    test('tolerates spaces and dashes', () {
      expect(BusinessNumberValidator.isValid('123 456-789'), isTrue);
      expect(BusinessNumberValidator.normalize('123 456-789'), '123456789');
    });

    test('rejects wrong length or non-digits', () {
      expect(BusinessNumberValidator.isValid('12345678'), isFalse);
      expect(BusinessNumberValidator.isValid('1234567890'), isFalse);
      expect(BusinessNumberValidator.isValid('12345678A'), isFalse);
    });

    test('rejects null', () {
      expect(BusinessNumberValidator.isValid(null), isFalse);
    });
  });
}
