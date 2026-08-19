import 'package:growth_pilot_ai/business/compute_text_overlap_score.dart';
import 'package:growth_pilot_ai/business/find_shared_keywords.dart';
import 'package:growth_pilot_ai/core/data/entities/business_goal_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/suggested_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "Background Linker: scan the entire project for new potential
/// relationships" (Issue #244) — skips pairs that are already linked
/// or already have a suggestion (pending, approved, or rejected — the
/// "Feedback Loop" AC: a rejected pair is never re-suggested).
class GenerateLinkSuggestions {
  static const threshold = 0.15;

  static List<SuggestedLinkEntity> call({
    required List<BusinessGoalEntity> goals,
    required List<TraceableRequirementEntity> requirements,
    required List<GoalRequirementLinkEntity> existingLinks,
    required List<SuggestedLinkEntity> existingSuggestions,
  }) {
    final linkedPairs = existingLinks.map((l) => '${l.goal.targetId}:${l.requirement.targetId}').toSet();
    final suggestedPairs =
        existingSuggestions.map((s) => '${s.goal.targetId}:${s.requirement.targetId}').toSet();

    final results = <SuggestedLinkEntity>[];
    for (final goal in goals) {
      for (final requirement in requirements) {
        final key = '${goal.id}:${requirement.id}';
        if (linkedPairs.contains(key) || suggestedPairs.contains(key)) continue;

        final score = ComputeTextOverlapScore.call(goal.title, requirement.description);
        if (score < threshold) continue;

        final shared = FindSharedKeywords.call(goal.title, requirement.description);
        results.add(SuggestedLinkEntity(
          confidenceScore: score,
          reasoning: 'Both mention: ${shared.join(', ')}',
        )
          ..goal.targetId = goal.id
          ..requirement.targetId = requirement.id);
      }
    }
    return results;
  }
}
