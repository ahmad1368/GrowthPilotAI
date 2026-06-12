import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/features/document_classification/data/services/tflite_classifier_service.dart';

void main() {
  group('TFliteClassifierService Unit Tests', () {
    late TFliteClassifierService service;

    setUp(() {
      service = TFliteClassifierService();
    });

    test('Should handle resources properly on dispose', () {
      expect(() => service.dispose(), returnsNormally);
    });
  });
}
