import 'package:flutter_test/flutter_test.dart';
import 'package:growth_pilot_ai/business/generate_link_suggestions.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/suggested_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

void main() {
  group('GenerateLinkSuggestions', () {
    final goal = BusinessGoalEntity(id: 1, title: 'Reduce customer wait time and response latency');
    final requirement = TraceableRequirementEntity(
        id: 100,
        reqCode: 'BR-01',
        description: 'The system shall reduce response latency for customer queries');

    test('suggests a link for an overlapping, unlinked pair', () {
      final result = GenerateLinkSuggestions.call(
        goals: [goal],
        requirements: [requirement],
        existingLinks: const [],
        existingSuggestions: const [],
      );

      expect(result, hasLength(1));
      expect(result.first.goal.targetId, 1);
      expect(result.first.requirement.targetId, 100);
      expect(result.first.reasoning, contains('customer'));
    });

    test('skips a pair that is already linked', () {
      final link = GoalRequirementLinkEntity()
        ..goal.targetId = 1
        ..requirement.targetId = 100;

      final result = GenerateLinkSuggestions.call(
        goals: [goal],
        requirements: [requirement],
        existingLinks: [link],
        existingSuggestions: const [],
      );

      expect(result, isEmpty);
    });

    test('skips a pair that already has a suggestion (even if rejected)', () {
      final existing = SuggestedLinkEntity(confidenceScore: 0.5, reasoning: 'x')
        ..goal.targetId = 1
        ..requirement.targetId = 100;

      final result = GenerateLinkSuggestions.call(
        goals: [goal],
        requirements: [requirement],
        existingLinks: const [],
        existingSuggestions: [existing],
      );

      expect(result, isEmpty);
    });
  });
}
