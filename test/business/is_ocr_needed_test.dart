import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_ocr_needed.dart';

void main() {
  group('IsOcrNeeded', () {
    test('true when extracted text is under the threshold', () {
      expect(IsOcrNeeded.call(50), isTrue);
    });

    test('false at exactly the threshold', () {
      expect(IsOcrNeeded.call(IsOcrNeeded.defaultThreshold), isFalse);
    });

    test('false well above the threshold', () {
      expect(IsOcrNeeded.call(5000), isFalse);
    });

    test('respects a custom threshold', () {
      expect(IsOcrNeeded.call(150, threshold: 200), isTrue);
    });
  });
}
