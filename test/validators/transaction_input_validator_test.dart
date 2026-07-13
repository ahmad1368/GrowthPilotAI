import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/input_sanitizer.dart';
import 'package:growth_pilot_ai/validators/transaction_input_validator.dart';

void main() {
  group('InputSanitizer', () {
    test('clean strips HTML tags (leaving inert text) and trims', () {
      expect(InputSanitizer.clean('  <b>Acme</b> Co  '), 'Acme Co');
      // Tags are removed so nothing executable survives; inner text is inert.
      expect(InputSanitizer.clean('<script>evil()</script>Bob'), 'evil()Bob');
    });

    test('escapeHtml escapes significant characters', () {
      expect(InputSanitizer.escapeHtml('<a href="x">'),
          '&lt;a href=&quot;x&quot;&gt;');
    });
  });

  group('TransactionInputValidator.merchantName', () {
    test('rejects names shorter than 3 or longer than 100', () {
      expect(TransactionInputValidator.merchantName('ab'), isNotNull);
      expect(TransactionInputValidator.merchantName('a' * 101), isNotNull);
    });

    test('accepts a trimmed valid name', () {
      expect(TransactionInputValidator.merchantName('  Staples  '), isNull);
    });
  });

  group('TransactionInputValidator.amount', () {
    test('rejects null, non-positive and >2 decimals', () {
      expect(TransactionInputValidator.amount(null), isNotNull);
      expect(TransactionInputValidator.amount(0), isNotNull);
      expect(TransactionInputValidator.amount(-5), isNotNull);
      expect(TransactionInputValidator.amount(10.005), isNotNull);
    });

    test('accepts a positive amount with up to 2 decimals', () {
      expect(TransactionInputValidator.amount(150.5), isNull);
      expect(TransactionInputValidator.amount(150.55), isNull);
    });
  });

  group('TransactionInputValidator.currency', () {
    test('accepts CAD/USD case-insensitively', () {
      expect(TransactionInputValidator.currency('cad'), isNull);
      expect(TransactionInputValidator.currency('USD'), isNull);
    });

    test('rejects unknown or null currency', () {
      expect(TransactionInputValidator.currency('EUR'), isNotNull);
      expect(TransactionInputValidator.currency(null), isNotNull);
    });
  });
}
