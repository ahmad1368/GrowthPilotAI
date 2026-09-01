import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_url_secure.dart';

void main() {
  group('IsUrlSecure', () {
    test('true for an https URL', () {
      expect(IsUrlSecure.call('https://api.example.ca/v1/accounts'), isTrue);
    });

    test('false for a plaintext http URL', () {
      expect(IsUrlSecure.call('http://api.example.ca/v1/accounts'), isFalse);
    });

    test('false for a scheme-relative or malformed URL', () {
      expect(IsUrlSecure.call('//api.example.ca'), isFalse);
      expect(IsUrlSecure.call('not-a-url'), isFalse);
    });
  });
}
