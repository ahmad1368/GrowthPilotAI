import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/extract_requirements_from_text.dart';
import 'package:growth_pilot_ai/core/enum/requirement_triage_status.dart';

void main() {
  group('ExtractRequirementsFromText', () {
    test('extracts only sentences with a requirement indicator', () {
      final requirements = ExtractRequirementsFromText.call(
          'The system shall allow login. This is background context. Users must reset passwords.');

      expect(requirements.length, 2);
      expect(requirements[0].description, contains('shall allow login'));
      expect(requirements[1].description, contains('must reset passwords'));
    });

    test('every extracted requirement starts pending', () {
      final requirements = ExtractRequirementsFromText.call('The system shall log events.');

      expect(requirements.single.status, RequirementTriageStatus.pending);
    });

    test('offsets trace back to the source text', () {
      const text = 'Intro. The system shall export data.';
      final requirements = ExtractRequirementsFromText.call(text);

      final r = requirements.single;
      expect(text.substring(r.startIndex, r.endIndex), r.description);
    });

    test('no candidates in plain narrative text', () {
      expect(ExtractRequirementsFromText.call('This document describes the process.'), isEmpty);
    });
  });
}
