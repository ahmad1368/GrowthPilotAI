import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/submit_interac_reference.dart';

void main() {
  test('accepts a well-formed alphanumeric reference', () {
    expect(SubmitInteracReference.isValid('ABC12345'), isTrue);
  });

  test('rejects a reference that is too short', () {
    expect(SubmitInteracReference.isValid('AB1'), isFalse);
  });

  test('rejects a reference with invalid characters', () {
    expect(SubmitInteracReference.isValid('ABC-123-XYZ'), isFalse);
  });

  test('rejects an empty reference', () {
    expect(SubmitInteracReference.isValid(''), isFalse);
  });
}
