import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/core/validators/ocr_error_handler.dart';

void main() {
  group('OCRResult Error Handler Tests', () {
    test('Should throw empty result explicit exception message', () {
      final exception = Exception('empty_result');

      expect(
        () => OCRErrorHandler.handle(exception, StackTrace.current),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('تصویر خوانا نیست'))),
      );
    });

    test('Should throw low storage exception message', () {
      final exception = Exception('low_storage');

      expect(
        () => OCRErrorHandler.handle(exception, StackTrace.current),
        throwsA(isA<Exception>().having(
            (e) => e.toString(), 'message', contains('فضای حافظه کافی نیست'))),
      );
    });
  });
}
