import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/validators/pulse_report_validator.dart';

void main() {
  group('PulseReportValidator', () {
    test('title rejects too-short and too-long values', () {
      expect(PulseReportValidator.title('abcd'), isNotNull);
      expect(PulseReportValidator.title('a' * 81), isNotNull);
      expect(PulseReportValidator.title('Valid title'), isNull);
    });

    test('description rejects too-short and too-long values', () {
      expect(PulseReportValidator.description('short'), isNotNull);
      expect(PulseReportValidator.description('a' * 501), isNotNull);
      expect(PulseReportValidator.description('A sufficiently long description.'), isNull);
    });

    test('estimatedImpactCad rejects null and negative values', () {
      expect(PulseReportValidator.estimatedImpactCad(null), isNotNull);
      expect(PulseReportValidator.estimatedImpactCad(-1), isNotNull);
      expect(PulseReportValidator.estimatedImpactCad(0), isNull);
      expect(PulseReportValidator.estimatedImpactCad(500), isNull);
    });
  });
}
