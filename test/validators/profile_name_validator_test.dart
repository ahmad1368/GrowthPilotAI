import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/profile_name_validator.dart';

void main() {
  group('ProfileNameValidator', () {
    test('rejects an empty name', () {
      expect(ProfileNameValidator.call(''), isNotNull);
    });

    test('rejects a whitespace-only name', () {
      expect(ProfileNameValidator.call('   '), isNotNull);
    });

    test('rejects null', () {
      expect(ProfileNameValidator.call(null), isNotNull);
    });

    test('rejects a name longer than 60 characters', () {
      expect(ProfileNameValidator.call('a' * 61), isNotNull);
    });

    test('accepts a normal name', () {
      expect(ProfileNameValidator.call('Ahmad'), isNull);
    });

    test('accepts a name at exactly 60 characters', () {
      expect(ProfileNameValidator.call('a' * 60), isNull);
    });
  });
}
