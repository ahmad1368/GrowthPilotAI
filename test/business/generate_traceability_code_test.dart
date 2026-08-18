import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_traceability_code.dart';

void main() {
  group('GenerateTraceabilityCode', () {
    test('generates the first code as 01', () {
      expect(GenerateTraceabilityCode.call('BR', 0), 'BR-01');
    });

    test('increments and zero-pads based on existing count', () {
      expect(GenerateTraceabilityCode.call('TC', 8), 'TC-09');
      expect(GenerateTraceabilityCode.call('BR', 11), 'BR-12');
    });
  });
}
