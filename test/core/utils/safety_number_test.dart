import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/utils/safety_number.dart';

void main() {
  const keyA = 'BASE64_PUBLIC_KEY_ALICE';
  const keyB = 'BASE64_PUBLIC_KEY_BOB';

  group('SafetyNumber.fingerprint', () {
    test('is a deterministic 30-digit string', () {
      final fp = SafetyNumber.fingerprint(keyA);
      expect(fp, SafetyNumber.fingerprint(keyA));
      expect(fp, matches(RegExp(r'^\d{30}$')));
    });

    test('differs for different keys', () {
      expect(SafetyNumber.fingerprint(keyA),
          isNot(SafetyNumber.fingerprint(keyB)));
    });
  });

  group('SafetyNumber.forPair', () {
    test('is identical for both participants (order-independent)', () {
      expect(SafetyNumber.forPair(keyA, keyB),
          SafetyNumber.forPair(keyB, keyA));
    });

    test('renders 60 digits in twelve 5-digit groups', () {
      final number = SafetyNumber.forPair(keyA, keyB);
      final groups = number.split(' ');
      expect(groups.length, 12);
      expect(groups.every((g) => RegExp(r'^\d{5}$').hasMatch(g)), isTrue);
    });

    test('changes if a party key is substituted (MITM detection)', () {
      final legit = SafetyNumber.forPair(keyA, keyB);
      final tampered = SafetyNumber.forPair(keyA, 'ATTACKER_KEY');
      expect(legit, isNot(tampered));
    });
  });
}
