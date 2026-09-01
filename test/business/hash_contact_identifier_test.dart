import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/hash_contact_identifier.dart';

void main() {
  test('produces a 64-character hex SHA-256 digest', () {
    final hash = HashContactIdentifier.call('merchant@example.com');
    expect(hash.length, 64);
    expect(RegExp(r'^[0-9a-f]{64}$').hasMatch(hash), true);
  });

  test('is stable for equivalent inputs after normalization', () {
    expect(HashContactIdentifier.call('604-555-0101'), HashContactIdentifier.call('604 555 0101'));
  });

  test('differs for different inputs', () {
    expect(HashContactIdentifier.call('a@example.com'), isNot(HashContactIdentifier.call('b@example.com')));
  });
}
