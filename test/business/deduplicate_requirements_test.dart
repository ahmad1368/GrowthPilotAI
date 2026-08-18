import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/deduplicate_requirements.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';
import 'package:growth_pilot_ai/core/models/extracted_requirement.dart';

ExtractedRequirement _req(String description, {int start = 0}) => ExtractedRequirement(
      description: description,
      type: RequirementType.functional,
      indicator: 'shall',
      priorityHint: RequirementPriorityHint.medium,
      moscowPriority: RequirementMoscowPriority.shouldHave,
      stakeholder: 'Unassigned',
      startIndex: start,
      endIndex: start + description.length,
      confidence: 0.9,
    );

void main() {
  group('DeduplicateRequirements', () {
    test('keeps only the first of two identical descriptions', () {
      final result = DeduplicateRequirements.call([
        _req('The system shall log events.', start: 0),
        _req('The system shall log events.', start: 100),
      ]);

      expect(result.length, 1);
      expect(result.first.startIndex, 0);
    });

    test('is case- and whitespace-insensitive', () {
      final result = DeduplicateRequirements.call([
        _req('The system  shall log events.'),
        _req('the system shall log events.'),
      ]);

      expect(result.length, 1);
    });

    test('keeps distinct requirements', () {
      final result = DeduplicateRequirements.call([
        _req('The system shall log events.'),
        _req('The system shall export data.'),
      ]);

      expect(result.length, 2);
    });
  });
}
