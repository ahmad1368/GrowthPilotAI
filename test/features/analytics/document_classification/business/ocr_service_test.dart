import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/business/ocr_service.dart';
import 'package:mockito/mockito.dart';

class MockFile extends Mock implements File {}

void main() {
  group('OCRService Scalable Unit Tests', () {
    late OCRService ocrService;

    setUp(() {
      ocrService = OCRService();
    });

    test('Should release native resources on dispose', () {
      expect(() => ocrService.dispose(), returnsNormally);
    });
  });
}
