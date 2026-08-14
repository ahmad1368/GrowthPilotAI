import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_contact_identifier_type.dart';
import 'package:growth_pilot_ai/core/enum/contact_identifier_type.dart';

void main() {
  test('classifies an @-containing string as an email', () {
    expect(ClassifyContactIdentifierType.call('beta@example.com'), ContactIdentifierType.email);
  });

  test('classifies a plain number as a phone', () {
    expect(ClassifyContactIdentifierType.call('+16045550101'), ContactIdentifierType.phone);
  });
}
