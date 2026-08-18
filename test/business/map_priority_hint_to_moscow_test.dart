import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/map_priority_hint_to_moscow.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/requirement_priority_hint.dart';

void main() {
  group('MapPriorityHintToMoscow', () {
    test('high maps to mustHave', () {
      expect(MapPriorityHintToMoscow.call(RequirementPriorityHint.high),
          RequirementMoscowPriority.mustHave);
    });

    test('medium maps to shouldHave', () {
      expect(MapPriorityHintToMoscow.call(RequirementPriorityHint.medium),
          RequirementMoscowPriority.shouldHave);
    });

    test('low maps to couldHave', () {
      expect(MapPriorityHintToMoscow.call(RequirementPriorityHint.low),
          RequirementMoscowPriority.couldHave);
    });
  });
}
