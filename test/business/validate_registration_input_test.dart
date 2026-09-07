import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_registration_input.dart';

void main() {
  group('ValidateRegistrationInput', () {
    test('accepts valid, matching input', () {
      expect(
        ValidateRegistrationInput.call(
            'new-user@example.com', 'StrongPass1', 'StrongPass1'),
        isNull,
      );
    });

    test('rejects when any field is empty', () {
      expect(ValidateRegistrationInput.call('', 'StrongPass1', 'StrongPass1'),
          isNotNull);
      expect(
          ValidateRegistrationInput.call('new-user@example.com', '', 'StrongPass1'),
          isNotNull);
      expect(
          ValidateRegistrationInput.call(
              'new-user@example.com', 'StrongPass1', ''),
          isNotNull);
    });

    test('rejects a malformed email', () {
      expect(
        ValidateRegistrationInput.call(
            'not-an-email', 'StrongPass1', 'StrongPass1'),
        isNotNull,
      );
    });

    test('rejects a password shorter than the minimum length', () {
      expect(
        ValidateRegistrationInput.call('new-user@example.com', 'short', 'short'),
        isNotNull,
      );
    });

    test('rejects mismatched password and confirmation', () {
      expect(
        ValidateRegistrationInput.call(
            'new-user@example.com', 'StrongPass1', 'StrongPass2'),
        isNotNull,
      );
    });
  });
}
