import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/classify_requirement_type.dart';
import 'package:growth_pilot_ai/core/enum/requirement_type.dart';

void main() {
  group('ClassifyRequirementType', () {
    test('technical keywords win', () {
      expect(ClassifyRequirementType.call('The system shall integrate with the payment API.'),
          RequirementType.technical);
    });

    test('non-functional keywords', () {
      expect(ClassifyRequirementType.call('The system shall maintain 99.9% availability.'),
          RequirementType.nonFunctional);
    });

    test('business-rule keywords', () {
      expect(ClassifyRequirementType.call('Refunds must comply with company policy.'),
          RequirementType.businessRule);
    });

    test('falls back to functional', () {
      expect(ClassifyRequirementType.call('The system shall allow users to log in.'),
          RequirementType.functional);
    });
  });
}
