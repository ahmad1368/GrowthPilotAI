import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_credit_card.dart';

void main() {
  test('redacts a Luhn-valid card number', () {
    expect(RedactCreditCard.call('Card: 4532015112830366'), 'Card: [REDACTED_CARD]');
  });

  test('redacts a Luhn-valid card number with spaces', () {
    expect(RedactCreditCard.call('Card: 4532 0151 1283 0366'), 'Card: [REDACTED_CARD]');
  });

  // The issue's own AC: a same-length number that fails Luhn (e.g. a
  // business/reference number) must not be falsely redacted.
  test('does not redact a same-length number that fails the Luhn check', () {
    const text = 'Ref: 1234567890123456';
    expect(RedactCreditCard.call(text), text);
  });

  test('leaves ordinary text unchanged', () {
    expect(RedactCreditCard.call('See you at 5pm.'), 'See you at 5pm.');
  });
}
