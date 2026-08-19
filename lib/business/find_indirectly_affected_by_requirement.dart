import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "IndirectlyAffected: Secondary dependencies" (Issue #240) — this
/// repo's graph has no requirement-to-requirement edges, so "indirect"
/// means sibling requirements that support at least one of the same
/// business goals (a two-hop Requirement -> Goal -> Requirement walk),
/// since editing one may affect what the shared goal still needs.
class FindIndirectlyAffectedByRequirement {
  static List<TraceableRequirementEntity> call(
    int requirementId,
    List<GoalRequirementLinkEntity> goalLinks,
    List<TraceableRequirementEntity> allRequirements,
  ) {
    final sharedGoalIds = goalLinks
        .where((l) => l.requirement.targetId == requirementId)
        .map((l) => l.goal.targetId)
        .toSet();
    final siblingIds = goalLinks
        .where((l) => sharedGoalIds.contains(l.goal.targetId) && l.requirement.targetId != requirementId)
        .map((l) => l.requirement.targetId)
        .toSet();
    return allRequirements.where((r) => siblingIds.contains(r.id)).toList();
  }
}
