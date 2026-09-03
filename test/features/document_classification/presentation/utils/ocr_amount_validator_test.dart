import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/presentation/utils/ocr_amount_validator.dart';

/// Covers Issue #27's AC: "Save button is disabled if the Amount is
/// invalid." Save used to silently default an invalid amount to 0.0 and
/// save anyway instead of blocking it.
void main() {
  group('OcrAmountValidator.validate', () {
    test('accepts a valid positive amount', () {
      expect(OcrAmountValidator.validate('45.20'), isNull);
    });

    test('rejects an empty value', () {
      expect(OcrAmountValidator.validate(''), isNotNull);
    });

    test('rejects a null value', () {
      expect(OcrAmountValidator.validate(null), isNotNull);
    });

    test('rejects non-numeric text', () {
      expect(OcrAmountValidator.validate('not a number'), isNotNull);
    });

    test('rejects zero', () {
      expect(OcrAmountValidator.validate('0'), isNotNull);
    });

    test('rejects a negative amount', () {
      expect(OcrAmountValidator.validate('-5.00'), isNotNull);
    });
  });
}
