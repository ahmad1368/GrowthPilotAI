import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deserialize_amount_from_encryption.dart';
import 'package:growth_pilot_ai/business/serialize_amount_for_encryption.dart';

void main() {
  group('DeserializeAmountFromEncryption', () {
    test('parses a serialized amount back to a double', () {
      expect(DeserializeAmountFromEncryption.call('42.00'), 42.0);
    });

    test('round-trips through SerializeAmountForEncryption', () {
      final serialized = SerializeAmountForEncryption.call(1234.5);

      expect(DeserializeAmountFromEncryption.call(serialized), 1234.5);
    });
  });
}
