import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/is_inference_timeout.dart';

void main() {
  group('IsInferenceTimeout', () {
    test('false when well under the 5-second limit', () {
      expect(IsInferenceTimeout.call(1200), isFalse);
    });

    test('false at exactly 5 seconds', () {
      expect(IsInferenceTimeout.call(5000), isFalse);
    });

    test('true once the limit is exceeded', () {
      expect(IsInferenceTimeout.call(5001), isTrue);
    });
  });
}
