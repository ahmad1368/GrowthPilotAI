import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/redact_sin.dart';

void main() {
  test('redacts a SIN-formatted number', () {
    expect(RedactSin.call('My SIN is 123-456-789, call me.'),
        'My SIN is [REDACTED_SIN], call me.');
  });

  test('leaves ordinary text unchanged', () {
    expect(RedactSin.call('See you at 5pm.'), 'See you at 5pm.');
  });
}
