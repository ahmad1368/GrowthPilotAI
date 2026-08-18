import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/filter_requirements_by_quick_filter.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';
import 'package:growth_pilot_ai/core/enum/requirement_moscow_priority.dart';
import 'package:growth_pilot_ai/core/enum/traceability_quick_filter.dart';

TraceableRequirementEntity _req(int id, {RequirementMoscowPriority? priority}) =>
    TraceableRequirementEntity(
        id: id, reqCode: 'BR-0$id', description: 'req $id', dbMoscowPriority: priority?.index);

void main() {
  group('FilterRequirementsByQuickFilter', () {
    final requirements = [
      _req(1, priority: RequirementMoscowPriority.mustHave),
      _req(2, priority: RequirementMoscowPriority.couldHave),
    ];

    test('null filter returns everything unchanged', () {
      final result = FilterRequirementsByQuickFilter.call(requirements, null,
          requirementIdsWithoutGoal: {}, requirementIdsWithoutTestCase: {});

      expect(result, requirements);
    });

    test('gapsOnly keeps only requirements without a goal', () {
      final result = FilterRequirementsByQuickFilter.call(requirements, TraceabilityQuickFilter.gapsOnly,
          requirementIdsWithoutGoal: {2}, requirementIdsWithoutTestCase: {});

      expect(result.map((r) => r.id), [2]);
    });

    test('untestedReqs keeps only requirements without a test case', () {
      final result = FilterRequirementsByQuickFilter.call(
          requirements, TraceabilityQuickFilter.untestedReqs,
          requirementIdsWithoutGoal: {}, requirementIdsWithoutTestCase: {1});

      expect(result.map((r) => r.id), [1]);
    });

    test('highPriority keeps only Must-Have requirements', () {
      final result = FilterRequirementsByQuickFilter.call(
          requirements, TraceabilityQuickFilter.highPriority,
          requirementIdsWithoutGoal: {}, requirementIdsWithoutTestCase: {});

      expect(result.map((r) => r.id), [1]);
    });
  });
}
