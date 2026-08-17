import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/serialize_amount_for_encryption.dart';

void main() {
  group('SerializeAmountForEncryption', () {
    test('formats to a fixed 2-decimal string', () {
      expect(SerializeAmountForEncryption.call(42), '42.00');
      expect(SerializeAmountForEncryption.call(19.5), '19.50');
      expect(SerializeAmountForEncryption.call(19.999), '20.00');
    });
  });
}
