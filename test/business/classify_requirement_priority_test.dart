import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_requirement_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';

void main() {
  group('ClassifyRequirementPriority', () {
    test('mandatory language is high', () {
      expect(ClassifyRequirementPriority.call('This is a mandatory requirement.'),
          RequirementPriorityHint.high);
    });

    test('optional language is low', () {
      expect(ClassifyRequirementPriority.call('The system may optionally cache results.'),
          RequirementPriorityHint.low);
    });

    test('neutral language defaults to medium', () {
      expect(ClassifyRequirementPriority.call('The system shall allow users to log in.'),
          RequirementPriorityHint.medium);
    });
  });
}
