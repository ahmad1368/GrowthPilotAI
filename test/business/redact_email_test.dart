import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_email.dart';

void main() {
  test('redacts an email address', () {
    expect(RedactEmail.call('Reach me at jane.doe@example.com please.'),
        'Reach me at [REDACTED_EMAIL] please.');
  });

  test('leaves ordinary text unchanged', () {
    expect(RedactEmail.call('See you at 5pm.'), 'See you at 5pm.');
  });
}
