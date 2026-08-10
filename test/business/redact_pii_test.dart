import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_pii.dart';

void main() {
  test('redacts a SIN, a card number, and an email in one pass', () {
    const text = 'SIN 123-456-789, card 4532015112830366, email a@b.com';
    final result = RedactPii.call(text);

    expect(result, contains('[REDACTED_SIN]'));
    expect(result, contains('[REDACTED_CARD]'));
    expect(result, contains('[REDACTED_EMAIL]'));
    expect(result, isNot(contains('123-456-789')));
    expect(result, isNot(contains('4532015112830366')));
    expect(result, isNot(contains('a@b.com')));
  });

  test('leaves ordinary text unchanged', () {
    const text = 'Let us meet at 5pm tomorrow.';
    expect(RedactPii.call(text), text);
  });
}
