import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/normalize_contact_identifier.dart';

void main() {
  test('strips spacing/formatting from phone numbers', () {
    expect(NormalizeContactIdentifier.call('+1 (604) 555-0101'), '+16045550101');
  });

  test('lowercases emails without stripping formatting', () {
    expect(NormalizeContactIdentifier.call('  Merchant@Example.com '), 'merchant@example.com');
  });

  test('produces the same result regardless of input spacing', () {
    expect(NormalizeContactIdentifier.call('604-555-0101'),
        NormalizeContactIdentifier.call('604 555 0101'));
  });
}
