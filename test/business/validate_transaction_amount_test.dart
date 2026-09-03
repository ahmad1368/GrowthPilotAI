import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/validate_transaction_amount.dart';

void main() {
  group('ValidateTransactionAmount', () {
    test('accepts a positive amount without throwing', () {
      expect(() => ValidateTransactionAmount.call(89.50), returnsNormally);
    });

    test('rejects a zero amount', () {
      expect(() => ValidateTransactionAmount.call(0.0), throwsArgumentError);
    });

    test('rejects a negative amount', () {
      expect(() => ValidateTransactionAmount.call(-25.00), throwsArgumentError);
    });
  });
}
