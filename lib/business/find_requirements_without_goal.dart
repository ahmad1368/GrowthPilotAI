import 'package:growth_pilot_ai/core/data/entities/goal_requirement_link_entity.dart';
import 'package:growth_pilot_ai/core/data/entities/traceable_requirement_entity.dart';

/// "Empty Rows: Highlight requirements with no linked business goals in
/// red" (Issue #239's Gap Analysis).
class FindRequirementsWithoutGoal {
  static List<TraceableRequirementEntity> call(
      List<TraceableRequirementEntity> requirements, List<GoalRequirementLinkEntity> allLinks) {
    final linkedIds = allLinks.map((l) => l.requirement.targetId).toSet();
    return requirements.where((r) => !linkedIds.contains(r.id)).toList();
  }
}
